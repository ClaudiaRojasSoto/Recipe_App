class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  # has_and_belongs_to_many :foods, join_table: 'recipe_foods'
  has_many :foods, through: :recipe_foods
  scope :public_recipes, -> { where(public: true).order(created_at: :desc) }

  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true

  def total_foods_price
    prices = []

    foods.each do |food|
      recipe_food = RecipeFood.find_by(recipe_id: id, food_id: food.id)
      food_total = (recipe_food.quantity * food.price)
      puts '--------------------------------------'
      puts "recipe: #{name}, food: #{food.name}, quantity: #{recipe_food.quantity}, price: #{food.price}"
      prices.push(food_total)
    end
    prices.sum
  end
end
