class Public::CartItemsController < ApplicationController

  def index
    @customer = current_customer
    @cart_items = @customer.cart_items
    @cart_amount = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.item_id = cart_item_params[:item_id]
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
      render template: "public/items/show"
    end
  end

  def destroy_all
    current_customer.cart_item.destroy_all
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      render :create
    end
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
