class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_detail = Order_detail.find(@order.id)
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order.id)
    else
      render :show
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
  
end
