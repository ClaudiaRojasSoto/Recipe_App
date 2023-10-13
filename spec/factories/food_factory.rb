FactoryBot.define do
  factory :food do
    name { Faker::Food.dish }
    measurement_unit { 'grams' }
    price { Faker::Commerce.price(range: 1.0..10.0, as_string: false) }
    quantity { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    is_deleted { false }
    association :user
  end
end
