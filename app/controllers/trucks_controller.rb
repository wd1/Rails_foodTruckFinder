class TrucksController < ApplicationController

  def index
    @user = current_user
    @trucks = Truck.trucks_by_zip(params[:zip])
    if params[:zip]
      @url = Truck.url_generator(params[:zip])
    end
    # if !params[:zip]
    #   @trucks = Truck.all
    # else
    #   @url = Truck.url_generator(params[:zip])
    #   @trucks = Truck.all.select{|tr| tr.location.zip == params[:zip]}
    # end
  end

  # def new
  # end
  #
  # def create
  # end

  def show
    # need to add some sort of location thingy to show page
    @truck = Truck.find(params[:id])
    session[:truck] = @truck.id
  end

  # def edit
  # end
  #
  # def update
  # end

end
