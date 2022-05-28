class Public::CommentsController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    comment = current_customer.comments.new(comment_params)
    comment.review_id = review.id
    if comment.save
      flash[:notice] = "コメントを投稿しました。"
      # redirect_to shop_review_path(review.shop_id, review.id)
      # app/views/public/comments/create.js.erbを参照する
    else
      flash[:alert] = "コメントの投稿に失敗しました。入力内容をご確認いただき、再度お試しください。"
      redirect_to request.referer
    end
  end


  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました。"
    # app/views/public/comments/destroy.js.erbを参照する
    # redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:customer_id, :review_id, :comment)
  end

end
