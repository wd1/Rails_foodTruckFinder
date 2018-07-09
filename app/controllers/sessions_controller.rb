class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :index]

  def index
  end

  def new
  end

  def create
    user = User.user_exist(params[:username])
    if user && user.authenticate(params[:password])
      # you are who you say you are

      session[:user_id] = user.id
      # flash[:message] = "Welcome #{user.full_name}"
      redirect_to user_path(user)
    elsif user == nil

      # sign in failed
      flash[:message] = "User Does not Exist. Please Sign Up."
      redirect_to signup_path
    else
      # sign in failed
      flash[:message] = "Wrong username and password"
      redirect_to signin_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to signin_path
  end



end
