class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorized

  helper_method :logged_in?
  helper_method :current_user

  # who is my current user
  # am i logged in or not
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end


  def authorized
    if logged_in?
    else
      redirect_to signin_path
    end
  end

end
