require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  it 'is valid with valid attributes' do
    recipe_food = create(:recipe_food)
    expect(recipe_food).to be_valid
  end

  it 'is not valid if the same combination of recipe_id and food_id already exists' do
    recipe = create(:recipe)
    food = create(:food)

    create(:recipe_food, recipe: recipe, food: food)
    recipe_food2 = build(:recipe_food, recipe: recipe, food: food)

    expect(recipe_food2).to_not be_valid
  end
end
