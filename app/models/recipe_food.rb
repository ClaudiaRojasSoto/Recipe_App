class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :recipe_id, uniqueness: { scope: :food_id, message: 'Ingredient already exists in the recipe' }
end
