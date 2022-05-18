class Public::ReviewsController < ApplicationController
 before_action :authenticate_customer!, only: [:create]

  def index
    # お店に紐づいたレビューの表示
    @shop = Shop.find(params[:shop_id])
    @reviews = @shop.reviews
  end

  def create
    shop = Shop.find(params[:shop_id])
    review = current_customer.reviews.new(review_params)
    review.shop_id = shop.id
    if review.save
      flash[:notice] = "レビューを投稿しました。"
      # レビューの一覧へ
      redirect_to shop_reviews_path(shop)
    else
      flash[:alert] = "レビューの投稿に失敗入力内容をご確認いただき、再度お試しください。"
      @shop = Shop.find(params[:shop_id])
      render "public/shops/show"
    end
  end

  def show
    @review = Review.find(params[:id])
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.new
    @comments = @review.comments
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "レビューを更新しました。"
      redirect_to shop_review_path(review.shop_id, review.id)
    else
      flash[:alert] = "レビューの更新に失敗しました。入力内容をご確認いただき、再度お試しください。"
      render "edit"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "レビューを削除しました。"
    redirect_to customer_path(current_customer)
  end


  private

  def review_params
    params.require(:review).permit(:customer_id, :shop_id, :title, :content, :review_image, :rate)
  end

end
