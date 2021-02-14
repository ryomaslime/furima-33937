FactoryBot.define do
  factory :purchase_address do
    postal_code    {'123-0011'}
    area_id        {5}
    city           {'東区'}
    house_number   {'櫻通1-2-3'}
    building_name  {'コーポレート101'}
    telephone      {'09012345678'}
    user_id        {1}
    item_id        {3}
    token          {"tok_abcdefghijk00000000000000000"}
  end
end
