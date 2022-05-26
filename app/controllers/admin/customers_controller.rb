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
    @customer.update(customer_params)
    redirect_to customer_path(customer.id)
  end

  def search
    @customers = Customer.looks(params[:word]).page(params[:page]).per(10)
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :is_status )
  end

end
