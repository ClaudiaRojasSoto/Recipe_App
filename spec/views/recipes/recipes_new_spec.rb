require 'rails_helper'

RSpec.feature 'New Recipe page', type: :feature do
  before(:each) do
    @user_owner = create(:user, name: 'Andy Zam')
  end

  scenario 'User creates a new recipe' do
    login_as(@user_owner, scope: :user)

    visit new_recipe_path

    expect(page).to have_content('New recipe')
    expect(page).to have_content('for Andy Zam')

    fill_in 'Name', with: 'Test Recipe'
    fill_in 'Preparation', with: 30
    fill_in 'recipe_cooking_time', with: 60
    fill_in 'Description', with: 'This is a test recipe.'
    check 'toggle'

    click_button 'Create Post'
  end
end
