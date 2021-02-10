FactoryBot.define do
  factory :item do
    item_name         {'インプレッサ'}
    item_explanation  {'スバルのインプレッサです'}
    category_id       {2} 
    state_id          {2}
    delivery_fee_id   {2}
    area_id           {2}
    duration_id       {2}
    price             {3000}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/dollars-499481_640.jpg'), filename: 'dollars-499481_640.jpg')
    end
  end
end
