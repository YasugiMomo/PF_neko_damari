class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @reviews = @customer.reviews.page(params[:page]).per(10)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました。"
      redirect_to customer_path(@customer)
    else
      flash[:alert] = "会員情報の更新に失敗しました。入力内容をご確認いただき、再度お試しください。"
      render "edit"
    end
  end

  # 退会確認用のビューを表示する
  def out
  end

  def quit
    @customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    if @customer.update(is_status: true)
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to root_path
    else
      flash[:alert] = "退会処理に失敗しました。"
      render "show"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :introduction, :profile_image)
  end

end
