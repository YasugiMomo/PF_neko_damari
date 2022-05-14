class Public::ReviewsController < ApplicationController
 before_action :authenticate_customer!, only: [:create]

  def index
    @shop = Shop.find(params[:shop_id])
    @reviews = @shop.reviews
  end

  def create
    @shop = Shop.find(params[:shop_id])
    @review = @shop.reviews.build(review_params)
    @review.customer_id = current_customer
    if @review.save
       flash[:notice] = "レビューを投稿しました。"
       # レビュー一覧へ
       redirect_to action: :index
    else
      @shop = Shop.find(params[:shop_id])
      @reviews = @shop.reviews
      flash[:error] = "レビューの投稿に失敗しました。"
      # 店舗詳細へ
      redirect_to root_path
    end
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
    params.require(:review).permit(:shop_id, :title, :content, :review_image, :rate)
  end

end
