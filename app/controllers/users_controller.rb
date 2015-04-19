class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_logged_in, only: [:index, :show, :edit, :update, :follow, :unfollow]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @status = Status.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User has been created."
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :index
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User has been updated"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def follow
    celeb = User.find(params[:id])
    if celeb && !following?(celeb)
      current_user.celebs << celeb
      flash[:notice] = "You are following #{celeb.username}."
      redirect_to statuses_path
    else
      flash[:error] = "There was an error."
      redirect_to statuses_path
    end
  end

  def unfollow
      celeb = User.find(params[:id])
      relation = Relationship.find_by(celebrity: celeb, fan: current_user)
    if relation
      relation.delete
      flash[:notice] = "You have unfollowed #{celeb.username}."
      redirect_to statuses_path
    else
      flash[:error] = "There was an error."
      redirect_to :back
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params[:user][:username].downcase!
    params.require(:user).permit(:username,:password, :email)
  end
end