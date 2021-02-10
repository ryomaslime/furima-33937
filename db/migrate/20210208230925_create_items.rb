class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|

      t.timestamps
      t.string :item_name, null: false
      t.text :item_explanation, null: false
      t.integer :category_id, null: false
      t.integer :state_id, null: false
      t.integer :delivery_fee_id, null: false
      t.integer :area_id, null: false
      t.integer :duration_id, null: false
      t.integer :price, null: false
      t.references :user, null: false, foreign_key: true
      
    end
  end
end
