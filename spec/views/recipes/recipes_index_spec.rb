require 'rails_helper'

RSpec.feature 'Recipe list page', type: :feature do
  before(:each) do
    @user = create(:user)
    @recipe1 = create(:recipe, user: @user, name: 'Recipe 1', description: 'Description 1')
    @recipe2 = create(:recipe, user: @user, name: 'Recipe 2', description: 'Description 2')
  end

  scenario 'User views the list of recipes' do
    login_as(@user, scope: :user)

    visit recipes_path

    expect(page).to have_content('List of recipes')

    expect(page).to have_content('Recipe 1')
    expect(page).to have_content('Recipe 2')
    expect(page).to have_content('Description 1')
    expect(page).to have_content('Description 2')

    expect(page).to have_link('Add new recipe', href: new_recipe_path)
  end
end
