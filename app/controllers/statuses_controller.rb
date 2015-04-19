class StatusesController < ApplicationController
  before_action :set_status, only: [:edit,:update,:destroy, :show]
  before_action :require_logged_in
 
  def index
    @status = Status.new
    @statuses = []
    @statuses << current_user.statuses
    current_user.celebs.each do |celeb|
      @statuses << celeb.statuses
    end
    @statuses.flatten!
    @statuses.sort! { |a, b|  a.created_at <=> b.created_at }
  end

  def show
    
  end
 
  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    @status.creator = User.find(current_user)

    if @status.save
      flash[:notice] = "status has been created."
      redirect_to statuses_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @status.update(status_params)
      flash[:notice] = "Status has been updated"
      redirect_to statuses_path
    else
      render :edit
    end
  end

  def destroy
    @status.destroy
    flash[:notice] = "Status has been deleted."
    redirect_to user_path(current_user)
  end

  def mentions
    @mentions = current_user.mentions
  end

  def retweet
    status = Status.find(params[:id])
    Status.create(body: status.body, user_id: current_user.id, parent_status: status)
    flash[:notice] = "Your retweet has been submitted."
    redirect_to statuses_path

  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def status_params
    params.require(:status).permit(:body)
  end
end