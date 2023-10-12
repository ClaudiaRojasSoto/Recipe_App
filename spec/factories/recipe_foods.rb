FactoryBot.define do
  factory :recipe_food do
    food
    recipe
    quantity { 1 }
  end
end
