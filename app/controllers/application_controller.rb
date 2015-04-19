class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :creator?, :following?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_logged_in
    unless logged_in?
      flash[:notice] = "You must be logged in to access that page."
      redirect_to root_path
    end
  end

  def creator?(user)
    current_user == user
  end

  def following?(user)
    current_user.celebs.include?(user)
  end
end
