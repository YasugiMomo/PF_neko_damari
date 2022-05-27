class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @reviews = @customer.reviews
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました。"
      redirect_to admin_customers_path
    else
      flash[:alert] = "会員情報の更新に失敗しました。"
      render "show"
    end
  end

  def search
    @customers = Customer.looks(params[:word]).page(params[:page]).per(10)
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :is_status )
  end

end
