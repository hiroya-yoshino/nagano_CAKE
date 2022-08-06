class Admin::ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
    redirect_to admin_item_path(params[:id])
    else
    render :new
    end
  end
  
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end
  
  before_action :set_genres, only: [:new, :create, :update]
  
  private
  
  def set_genres
    @genres = Genre.all
  end
  
  def item_params
    params.permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
  
end
