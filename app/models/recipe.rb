class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods
  scope :public_recipes, -> { where(public: true).order(created_at: :desc) }

  def total_foods_price
    prices = []

    foods.each do |food|
      recipe_food = RecipeFood.find_by(recipe_id: id, food_id: food.id)
      food_total = (recipe_food.quantity.to_i * food.price.to_i)
      prices.push(food_total)
    end
    prices.sum
  end  
end
