class ItemsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]

  def index
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

  private
  
  def item_params
    params.require(:item).permit(:item_name, :item_explanation, :category_id, :state_id, :delivery_fee_id, :area_id, :duration_id, :price, :image).merge(user_id: current_user.id)
  end
end
