class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @truck = Truck.find(session[:truck])
  end

  def create
    @truck = Truck.find(session[:truck])
    @review = Review.new(review_params(:title, :content, :rating))
    @review.user = current_user
    @review.truck = @truck

    if @review.valid?
      @review.save
      redirect_to truck_path(@review.truck)
    else
      # flash.delete(:error)
      flash[:notice] = @review.errors.full_messages[0]
      render :new
    end

  end

  # def show
  # end

  # def edit
  #   @review = Review.find(params[:id])
  # end
  #
  # def update
  # end

  private

  def review_params(*args)
    params.require(:review).permit(*args)
  end

end
