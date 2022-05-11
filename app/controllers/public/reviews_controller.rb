class Public::ReviewsController < ApplicationController
  def index
    @reviews = Reviews.all
  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer
    @review.shop_id =
    @review.save
    redirect_to
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
  end


  private

  def review_params
    params.require(:review).permit(:title, :content, :review_image)
  end

end
