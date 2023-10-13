require 'rails_helper'

RSpec.feature 'Add New Ingredient to Recipe page', type: :feature do
  before(:each) do
    @user = create(:user)
    @recipe = create(:recipe, user: @user, name: 'Test Recipe')
  end

  scenario 'User adds a new ingredient to the recipe' do
    login_as(@user, scope: :user)

    visit new_recipe_food_path(recipe_id: @recipe.id)

    expect(page).to have_content('Add new ingredient to recipe Test Recipe')

    fill_in 'recipe_food[quantity]', with: 2

    click_button 'Guardar'
  end
end
