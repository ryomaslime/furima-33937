class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :area_id, :city, :house_number, :building_name, :telephone, :token


  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :area_id, numericality: {other_than: 0}
    validates :city
    validates :house_number
    validates :telephone, length: {maximum: 11}, format: {with: /\A[0-9]+\z/}
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchase  = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, area_id: area_id, city: city, house_number: house_number, telephone: telephone, purchase_id: purchase.id)
  end
end