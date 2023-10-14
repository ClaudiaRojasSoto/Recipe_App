require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :feature do
  before(:each) do
    user = create(:user, name: 'Test User', email: 'test@example.com', password: 'password')

    create(
      :recipe,
      name: 'Test Recipe',
      user: user,
      preparation_time: '30',
      cooking_time: '45',
      description: 'Test description'
    )

    create(:food, name: 'Test Food', measurement_unit: 'grams', price: 2.5, quantity: 5)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  describe 'User can add a new ingredient to a recipe' do
    it 'creates a new ingredient' do
      visit new_recipe_food_path(recipe_id: Recipe.last.id)
      select 'Test Food', from: 'Food'
      fill_in 'Quantity', with: '2'
      click_button 'Guardar'

      expect(page).to have_text('The ingredient was added successfully!')
    end
  end
end
