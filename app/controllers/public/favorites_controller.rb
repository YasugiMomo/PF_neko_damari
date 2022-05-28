class Public::FavoritesController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    favorite = current_customer.favorites.new(review_id: @review.id)
    favorite.save
    # redirect_to request.referer
    # app/views/public/favorites/create.js.erbを参照する
  end

  def destroy
    @review = Review.find(params[:review_id])
    favorite = current_customer.favorites.find_by(review_id: @review.id)
    favorite.destroy
    # redirect_to request.referer
    # app/views/public/favorites/destroy.js.erbを参照する
  end
end
