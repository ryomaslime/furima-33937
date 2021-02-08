FactoryBot.define do
  factory :user do
    nickname              { 'ryoma' }
    email                 { 'aaa@aaa' }
    password              { 'tech0000' }
    password_confirmation { 'tech0000' }
    first_name            { '太郎' }
    first_name_reading    { 'タロウ' }
    last_name             { '山田' }
    last_name_reading     { 'ヤマダ' }
    birthday              { '1999-01-20' }
  end
end
