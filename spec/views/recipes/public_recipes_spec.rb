require 'rails_helper'

RSpec.feature 'Public Recipe List page', type: :feature do
  before(:each) do
    @public_user1 = create(:user, name: 'User 1')
    @public_user2 = create(:user, name: 'User 2')
    @user_owner = create(:user, name: 'Andy Zam')
    @recipe1 = create(:recipe, user: @public_user1, name: 'Recipe 1', public: true)
    @recipe2 = create(:recipe, user: @public_user2, name: 'Recipe 2', public: true)
  end

  scenario 'User views the public recipe list' do
    login_as(@user_owner, scope: :user)

    visit public_recipes_recipes_path

    expect(page).to have_content('Public Recipes')

    expect(page).to have_content('Recipe 1')
    expect(page).to have_content('Recipe 2')

    expect(page).to have_content('by User 1')
    expect(page).to have_content('by User 2')

    expect(page).to have_content('Total food items:')
    expect(page).to have_content('Total price:')

    within('.recipe-list') do
      expect(page).to have_selector('.recipe-item', count: 2)
    end
  end
end
