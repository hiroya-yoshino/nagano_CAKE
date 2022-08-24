class Public::CartItemsController < ApplicationController

  def index
    @customer = current_customer
    @cart_items = @customer.cart_items
    @cart_amount = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: @cart_item.item.id)
      @cart_item_total = current_customer.cart_items.find_by(item_id: @cart_item.item.id)
      @cart_item.amount = @cart_item.amount.to_i + @cart_item_total.amount.to_i
      @cart_item_total.update(amount: @cart_item.amount)
      redirect_to cart_items_path
    else
      if @cart_item.save
        redirect_to cart_items_path
      else
        render template: "public/items/show"
      end
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
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
