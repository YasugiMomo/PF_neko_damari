class Public::ReviewsController < ApplicationController
 before_action :authenticate_customer!, only: [:create]

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

  def create
    @shop = Shop.find(params[:shop_id])
    @review = current_customer.reviews.new(review_params)
    @review.shop_id = @shop.id
    @tag_list = params[:review][:tag_name].split(nil)
    if @review.save
      @review.save_tag(@tag_list)
      flash[:notice] = "レビューを投稿しました。"
      # レビューの一覧へ
      redirect_to shop_review_path(@review.shop_id, @review)
    else
      flash[:alert] = "レビューの投稿に失敗入力内容をご確認いただき、再度お試しください。"
      @shop = Shop.find(params[:shop_id])
      render "public/shops/show"
    end
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @reviews = @tag.reviews
  end

  def show
    @review = Review.find(params[:id])
    @shop = Shop.find(params[:shop_id])
    @comment = Comment.new
    @comments = @review.comments
    @review_tags = @review.tags
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if params[:review][:review_image_ids]
      params[:review][:review_image_ids].each do |image_id|
        review_image = @review.review_images.find(image_id)
        review_image.purge
      end
    end

    if @review.update(review_params)
      flash[:notice] = "レビューを更新しました。"
      redirect_to shop_review_path(@review.shop_id, @review)
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
    params.require(:review).permit(:customer_id, :shop_id, :title, :content, :rate, review_images: [])
  end

end
