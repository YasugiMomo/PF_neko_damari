class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
    @reviews = @customer.reviews
  end

  def edit
    @customer = current_customer
  end

  def update
    customer = current_customer
    customer.update(customer_params)
    flash[:notice] = "会員情報を更新しました。"
    redirect_to customer_path(customer.id)
  end

  # 退会確認用のビューを表示する
  def out
  end

  def quit
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_status: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :profile_image)
  end

end
