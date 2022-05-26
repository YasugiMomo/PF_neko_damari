class Admin::ReviewsController < ApplicationController

  def index
    @tag_list = Tag.all
    # お店に紐づいたレビューの表示
    @shop = Shop.find(params[:shop_id])
    # 絞り込み機能
    if params[:latest]
      @reviews = @shop.reviews.latest
    elsif params[:old]
      @reviews = @shop.reviews.old
    elsif params[:star_count]
      @reviews = @shop.reviews.star_count
    else
      @reviews = @shop.reviews
    end
  end

  def show
    @review = Review.find(params[:id])
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.new
    @comments = @review.comments
    @review_tags = @review.tags
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "レビューを削除しました。"
    redirect_to admin_shop_reviews_path(@review.shop_id, @review)
  end
end
