class Public::CommentsController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    comment = current_customer.comments.new(comment_params)
    comment.review_id = review.id
    comment.save
    redirect_to shop_review_path(review)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    redirect_to 
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to
  end

  private

  def comment_params
    params.require(:comment).permit(:customer_id, :review_id, :comment)
  end

end
