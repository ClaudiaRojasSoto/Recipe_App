# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = create(:user, name: 'Andy Zam', email: 'Andy@no.tiene', password: 'password')
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it 'has many foods' do
    user = create(:user)
    food1 = create(:food, user: user)
    food2 = create(:food, user: user)

    expect(user.foods).to include(food1, food2)
  end

  it 'has many recipes' do
    user = create(:user)
    recipe1 = create(:recipe, user: user)
    recipe2 = create(:recipe, user: user)

    expect(user.recipes).to include(recipe1, recipe2)
  end

  it 'returns all foods from their recipes' do
    user = create(:user)
    food1 = create(:food, user: user)
    food2 = create(:food, user: user)
    recipe = create(:recipe, user: user)
    create(:recipe_food, recipe: recipe, food: food1)
    create(:recipe_food, recipe: recipe, food: food2)

    foods = user.foods_all_recipes
    expect(foods).to include(food1, food2)
  end
end
