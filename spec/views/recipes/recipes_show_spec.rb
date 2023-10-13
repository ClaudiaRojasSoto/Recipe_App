require 'rails_helper'

RSpec.feature 'Recipe Details page', type: :feature do
  before(:each) do
    @user = create(:user)
    @recipe = create(:recipe, user: @user, name: 'Test Recipe', preparation_time: 30, cooking_time: 60,
                              description: 'This is a test recipe')
  end

  scenario 'User views recipe details' do
    login_as(@user, scope: :user)

    visit recipe_path(@recipe)

    expect(page).to have_content("Recipe #{@recipe.id}")
    expect(page).to have_content('Test Recipe')
    expect(page).to have_content('details')
    expect(page).to have_content('Preparation time: 30 hour')
    expect(page).to have_content('Cooking time: 60 hours')
    expect(page).to have_content('This is a test recipe')

    expect(page).to have_link('Generate shopping list', href: shopping_list_path)

    expect(page).to have_link('Add ingredient', href: new_recipe_food_path(recipe_id: @recipe.id))

    expect(page).to have_css('table')
    expect(page).to have_content('Food')
    expect(page).to have_content('Quantity')
    expect(page).to have_content('Value')

    create(:recipe_food, recipe: @recipe, food: create(:food, name: 'Ingredient', price: 10), quantity: 3)
    visit current_path
    expect(page).to have_content('Ingredient')
    expect(page).to have_content('3')
    expect(page).to have_content('30')

    expect(page).to have_selector("input[type='checkbox'][id='toggle1']")
  end
end
