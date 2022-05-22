class Admin::ReviewsController < ApplicationController

  def index
    @customer = (params[:customer_id])
    @reviews = @customer.reviews
    @tag_list = Tag.all
  end

  def show
    @review = Review.find(params[:id])
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.new
    @comments = @review.comments
    @review_tags = @review.tags
  end

  def destroy
    @customer = Customer.find(params[:id])
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "レビューを削除しました。"
    redirect_to customer_path(customer.id)
  end
end
