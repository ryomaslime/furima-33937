class ItemsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :edit, :update]
before_action :item_find, only: [:show, :edit, :update, :destroy, :move_to_index]
before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end 

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private
  
  def item_params
    params.require(:item).permit(:item_name, :item_explanation, :category_id, :state_id, :delivery_fee_id, :area_id, :duration_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    if current_user.id != @item.user.id
      redirect_to root_path
    end
  end

  def item_find
    @item = Item.find(params[:id])
  end
end
