class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :delivery_fee
  belongs_to :area
  belongs_to :duration
  belongs_to :user
  
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_explanation
    with_options numericality: {other_than: 1} do
      validates :category_id
      validates :state_id
      validates :delivery_fee_id
      validates :duration_id
    end
    validates :area_id, numericality: {other_than: 0}
    validates :price, numericality: {greater_than_or_equal_to: 300, less_than_or_equal_to:9999999}, format: {with: /\A[0-9]+\z/}
  end

end
