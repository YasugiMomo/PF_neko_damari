class Customers::SessionsController < Devise::SessionsController

  def guest_sign_in
    # guestアカウントがあれば取り出し、なければ作成する
    customer = Customer.guest
    sign_in customer   # ユーザーをログインさせる
    redirect_to shops_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end