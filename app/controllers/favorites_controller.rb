class FavoritesController < ApplicationController

  def create
    Favorite.create(user_id: current_user.id, truck_id: session[:truck])
    redirect_to truck_path(session[:truck])
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, truck_id: session[:truck]).destroy
    redirect_to truck_path(session[:truck])
  end

end
