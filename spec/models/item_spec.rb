require 'rails_helper'

RSpec.describe Item, type: :model do
  before do 
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it '商品画像、商品名、説明、カテゴリー、商品の状態、配送料、発送元、日数、価格についての情報があれば登録できること' do
        expect(@item).to be_valid
      end
      it '販売価格は半角数字のみ出品できること' do
        @item.price = 500
        expect(@item).to be_valid
      end
      it '販売価格が¥300以上の時出品できること' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it '販売価格が¥9999999以下の時出品できること' do
        @item.price = 9999999
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '商品画像がないと出品できないこと' do 
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名がないと出品できないこと' do
        @item.item_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品の説明がないと出品できないこと' do
        @item.item_explanation = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Item explanation can't be blank")
      end
      it 'カテゴリーの情報がないと出品できないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", "Category is not a number")
      end
      it '商品の状態についての情報がないと出品できないこと' do
        @item.state_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("State can't be blank", "State is not a number")
      end
      it '配送料の負担についての情報がないと出品できないこと' do
        @item.delivery_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee can't be blank", "Delivery fee is not a number")
      end
      it '発送元の地域についての情報がないと出品できないこと' do
        @item.area_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank", "Area is not a number")
      end
      it '発送までの日数についての情報がないと出品できないこと' do  
        @item.duration_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Duration can't be blank", "Duration is not a number")
      end
      it '販売価格についての情報がないと出品できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is not a number", "Price is invalid")
      end
      it '販売価格が¥300未満は出品できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '販売価格が¥9999999より大きいのは出品できないこと' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it '販売価格に半角英字があると出品できないこと' do
        @item.price = "aaa"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格に記号があると出品できないこと' do
        @item.price = "@@@"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格にひらがながあると出品できないこと' do
        @item.price = "あああ"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格にカタカナがあると出品できないこと' do
        @item.price = "アアア"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格に漢字があると出品できないこと' do
        @item.price = "漢漢漢"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'category_idが1の時は出品できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it 'state_idが1の時は出品できないこと' do
        @item.state_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("State must be other than 1")
      end
      it 'delivery_fee_idが1の時は出品できないこと' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee must be other than 1")
      end
      it 'duration_idが1の時は出品できないこと' do
        @item.duration_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Duration must be other than 1")
      end
      it 'area_idが0の時は出品できないこと' do
        @item.area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Area must be other than 0")
      end
    end
  end
end