class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @order.customer_id = @customer.id
    @addresses = @customer.addresses
  end

  def confirm
    @cart_items = current_customer.cart_items
    @cart_amount = 0
    if params[:order][:selected_button] == 'my_address'
      @order = Order.new
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postage = '800'
    elsif params[:order][:selected_button] == 'registed_address'
      @order = Order.new
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      @order.postage = '800'
    elsif params[:order][:selected_button] == 'new_address'
      @order = Order.new
      @order.postage = '800'
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render :new
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item.id
        @order_detail.price = cart_item.item.with_tax_price
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end
      @cart_items.destroy_all
      redirect_to orders_complete_path
    else
      @cart_amount = 0
      render :confirm
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
      params.require(:order).permit(:postal_code, :address, :name, :payment_method, :customer_id, :postage, :total_payment)
  end

  # params[:order][:selected_button]

end
