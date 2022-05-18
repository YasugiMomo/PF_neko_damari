class Public::CommentsController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    comment = current_customer.comments.new(comment_params)
    comment.review_id = review.id
    comment.save
    flash[:notice] = "コメントを投稿しました。"
    redirect_to shop_review_path(review.shop_id, review.id)
  end

  # def edit
  #   @comment = Comment.find(params[:id])
  # end

  # def update
  #   comment = Comment.find(params[:id])
  #   comment.update(comment_params)
  #   redirect_to
  # end

  def destroy
    @comment = Comment.find(id: params[:id], review_id: params[:review_id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to shop_review_path(@comment.review_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:customer_id, :review_id, :comment)
  end

end
