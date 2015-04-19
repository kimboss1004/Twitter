class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.username}, you have logged in!"
      redirect_to statuses_path
    else
      flash[:notice] = "Your username or password is incorrect."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Bye, you have logged out."
    redirect_to new_user_path
  end
end