FactoryBot.define do
  factory :recipe do
    name { 'Pasta' }
    preparation_time { 15 }
    cooking_time { 30 }
    description { 'Delicious pasta with tomato sauce.' }
    public { false }
    association :user
  end
end
