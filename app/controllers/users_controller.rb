class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new
    # byebug
    # session.delete(:user_id)
    @user = User.new
    @user.build_location
  end

  def create
    @user = User.new(users_params(:f_name, :l_name, :username, :password, :password_confirmation, :email, location_attributes: [
      :street_address,
      :city,
      :state,
      :zip,
      :neighborhood_id
    ]))
    if @user.save
      session[:user_id] = @user.id
      flash.delete(:notice)
      redirect_to user_path(@user)
    else
      flash[:notice] = @user.errors.full_messages[0]
      render :new
    end
  end

  def show
    # byebug
    # @user = User.find(params[:id])
    @user = User.find(session[:user_id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    # @user = User.find(params[:id])
    @user.update(users_params(:f_name, :l_name, :username, :password, :password_confirmation, :email, location_attributes: [
      :street_address,
      :city,
      :state,
      :zip,
      :neighborhood_id
    ]))
    if @user.save
      flash.delete(:notice)
      redirect_to user_path(@user)
    else
      flash[:notice] = @user.errors.full_messages[0]
      render :edit
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    # @user = User.find(params[:id])
    @user.cleanup
    @user.destroy
    # Make this better
    session.delete(:user_id)
    redirect_to signin_path
  end

  private

  def users_params(*args)
    params.require(:user).permit(*args)
  end

end
