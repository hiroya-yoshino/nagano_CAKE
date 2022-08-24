class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = @customer.addresses
  end
  
  private

  def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :postage, :total_payment)
  end
  
end
