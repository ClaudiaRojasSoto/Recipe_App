# spec/features/recipe_spec.rb
require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  let(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }

  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'User can see list of recipes' do
    visit recipes_path
    expect(page).to have_content('Pasta')
  end

  scenario 'User can view a single recipe' do
    visit recipe_path(recipe.id)
    expect(page).to have_content('Pasta')
    expect(page).to have_content('Delicious pasta with tomato sauce.')
  end

  scenario 'User can create a new recipe' do
    visit new_recipe_path
    fill_in 'Name', with: 'New Recipe'
    fill_in 'Preparation', with: 1
    fill_in 'Description', with: 'This is a test recipe.'
    click_button 'Create Post'
  end

  scenario 'User can delete a recipe' do
    visit recipes_path
    click_button 'REMOVE'
    expect(page).to have_content('The recipes was deleted successfully!')
  end
end
