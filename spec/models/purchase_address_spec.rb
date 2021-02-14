require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
      sleep(1)
    end

    context '購入できる時' do
      it '配送先の情報として郵便番号・都道府県・市区町村・番地・電話番号があり、クレカ入力としてtokenがあれば購入できること' do
        expect(@purchase_address).to be_valid
      end
      it '建物名が抜けていても購入できること' do
        @purchase_address.building_name = ""
        expect(@purchase_address).to be_valid
      end
    end
    context '購入できない時' do
      it '郵便番号がないと購入できないこと' do
        @purchase_address.postal_code = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid. Include hyphen(-)")
      end
      it '都道府県がないと購入できないこと' do
        @purchase_address.area_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Area can't be blank")
      end
      it '市区町村がないと購入できないこと' do
        @purchase_address.city = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地がないと購入できないこと' do
        @purchase_address.house_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号がないと購入できないこと' do
        @purchase_address.telephone = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone can't be blank")
      end
      it '郵便番号の保存にはハイフンがないと登録できないこと' do
        @purchase_address.postal_code = 1230012
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '電話番号は12桁以上の時には購入できないこと' do
        @purchase_address.telephone = '090123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone is too long (maximum is 11 characters)")
      end
      it '電話番号に半角英字があると購入できないこと' do
        @purchase_address.telephone = "aaa"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone is invalid")
      end
      it '電話番号に記号があると購入できないこと' do
        @purchase_address.telephone = "@@@"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone is invalid")
      end
      it '電話番号にひらがながあると購入できないこと' do
        @purchase_address.telephone = "あああ"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone is invalid")
      end
      it '電話番号にカタカナがあると購入できないこと' do
        @purchase_address.telephone = "アアア"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone is invalid")
      end
      it '電話番号に漢字があると購入できないこと' do
        @purchase_address.telephone = "関間幹"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone is invalid")
      end
      it 'area_idが0の時は購入できないこと' do
        @purchase_address.area_id = 0
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Area must be other than 0")
      end
      it '郵便番号に半角英字があると購入できないこと' do
        @purchase_address.postal_code = "aaa"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号に記号があると購入できないこと' do
        @purchase_address.postal_code = "@@@"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号にひらがながあると購入できないこと' do
        @purchase_address.postal_code = "あああ"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号にカタカナがあると購入できないこと' do
        @purchase_address.postal_code = "アアア"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号に漢字があると購入できないこと' do
        @purchase_address.postal_code = "漢漢漢"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'tokenがないときは購入できない' do
        @purchase_address.token = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空では購入できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では購入できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end

end

