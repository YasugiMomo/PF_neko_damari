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
      flash[:alert] = "入力内容に不備があります。再度入力してください。"
      @shop = Shop.find(params[:shop_id])
      render "public/shops/show"
    end
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
    @comments = @review.comments
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to shop_review_path(review.id)
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to
  end


  private

  def review_params
    params.require(:review).permit(:customer_id, :shop_id, :title, :content, :review_image, :rate)
  end

end
