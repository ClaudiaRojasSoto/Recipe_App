require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it 'is valid with valid attributes' do
    recipe = create(:recipe)
    expect(recipe).to be_valid
  end

  it 'is not valid without a name' do
    recipe = build(:recipe, name: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a preparation time' do
    recipe = build(:recipe, preparation_time: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a cooking time' do
    recipe = build(:recipe, cooking_time: nil)
    expect(recipe).to_not be_valid
  end

  it 'is not valid without a description' do
    recipe = build(:recipe, description: nil)
    expect(recipe).to_not be_valid
  end

  it 'calculates the total foods price correctly' do
    user = create(:user)
    food = create(:food, price: 5.0)
    recipe = create(:recipe, user: user)
    create(:recipe_food, recipe: recipe, food: food, quantity: 2)

    total_price = recipe.total_foods_price

    expect(total_price).to eq(10.0)
  end
end
