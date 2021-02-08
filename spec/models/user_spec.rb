require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、first_name、irst_name_reading、last_name、last_name_reading、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードとパスワード確認は6文字以上の半角英数字の混合が入力されていれば、登録できる' do
        @user.password = '00aabb'
        @user.password_confirmation = '00aabb'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性でないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@がないと登録できない' do
        @user.email = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワード確認が空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードとパスワード確認が一致しないと登録できない' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'aaa000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードが半角英字のみのとき登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードが半角数字のみのとき登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードに全角文字が入っているとき登録できない' do
        @user.password = 'あaaaaa'
        @user.password_confirmation = 'あaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードに記号が入っているとき登録できない' do
        @user.password = '@11111'
        @user.password_confirmation = '@11111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードが5文字以下のとき登録できない' do
        @user.password = '11111'
        @user.password_confirmation = '11111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)', 'Password is invalid')
      end
    end
  end
end

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/本人確認情報' do
    context '新規登録できるとき' do
      it 'ユーザー本名の名字は全角（漢字・ひらがな・カタカナ）での入力をすれば登録できる' do
        @user.last_name = '山田やまだヤマダ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名の名前は全角（漢字・ひらがな・カタカナ）での入力をすれば登録できる' do
        @user.first_name = '太郎たろうタロウ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナの名字は全角（カタカナ）での入力をすれば登録できる' do
        @user.last_name_reading = 'ヤマダ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナの名前は全角（カタカナ）での入力をすれば登録できる' do
        @user.first_name_reading = 'タロウ'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ユーザー本名は、名字がないと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank",
                                                      'Last name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名は、名前がないと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank",
                                                      'First name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名のフリガナは、名字がないと登録できない' do
        @user.last_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading can't be blank",
                                                      'Last name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名のフリガナは、名前がないと登録できない' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank",
                                                      'First name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名の名字は、半角数字があると登録できない' do
        @user.last_name = '11山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名の名字は、半角英字があると登録できない' do
        @user.last_name = 'aa山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名の名字は、記号があると登録できない' do
        @user.last_name = '@@山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名の名前は、半角数字があると登録できない' do
        @user.first_name = '11太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名の名前は、半角英字があると登録できない' do
        @user.first_name = 'aa太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名の名前は、記号があると登録できない' do
        @user.first_name = '@@太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end
      it 'ユーザー本名の名字のフリガナは、半角数字があると登録できない' do
        @user.last_name_reading = '11ヤマダ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名の名字のフリガナは、半角英字があると登録できない' do
        @user.last_name_reading = 'aaヤマダ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名の名字のフリガナは、記号があると登録できない' do
        @user.last_name_reading = '@@ヤマダ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名の名字のフリガナは、漢字があると登録できない' do
        @user.last_name_reading = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名の名字のフリガナは、ひらがながあると登録できない' do
        @user.last_name_reading = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名の名前のフリガナは、半角数字があると登録できない' do
        @user.first_name_reading = '11タロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名の名前のフリガナは、半角英字があると登録できない' do
        @user.first_name_reading = 'aaタロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名の名前のフリガナは、記号があると登録できない' do
        @user.first_name_reading = '@@タロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名の名前のフリガナは、漢字があると登録できない' do
        @user.first_name_reading = '太郎タロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
      end
      it 'ユーザー本名の名前のフリガナは、ひらがながあると登録できない' do
        @user.first_name_reading = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
      end
      it '生年月日がないとき登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
