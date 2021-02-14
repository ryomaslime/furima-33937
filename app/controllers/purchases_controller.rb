class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_index, only: [:index]
  before_action :sold_item, only: [:index]

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_address_params
    params.require(:purchase_address).permit(:postal_code, :area_id, :city, :house_number, :building_name, :telephone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end


  def move_to_index
    @product = Item.find(params[:item_id])
    if current_user.id == @product.user.id
      redirect_to root_path
    end
  end

  def sold_item
    @product = Item.find(params[:item_id])
    if @product.purchase
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
    Payjp::Charge.create(
        amount: Item.find(params[:item_id]).price,
        card: purchase_address_params[:token],
        currency: 'jpy'
    )
  end

end
