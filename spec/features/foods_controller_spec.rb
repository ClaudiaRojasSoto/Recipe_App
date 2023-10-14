require 'rails_helper'

RSpec.describe FoodsController, type: :feature do
  let(:user) { create(:user) }
  let(:food) { create(:food, user: user) }

  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  describe 'GET #index' do
    it 'visits foods#index' do
      visit foods_path
      expect(page).to have_content('Foods')
    end
  end

  describe 'GET #new' do
    it 'visits foods#new' do
      visit new_food_path
      expect(page).to have_content('New Food')
    end
  end

  describe 'POST #create' do
    it 'creates a new food item' do
      visit new_food_path

      fill_in 'Food Name', with: 'Apple' # Line 13
      select 'g', from: 'food_measurement_unit' # Line 14
      fill_in 'Price', with: 2.5 # Line 15
      fill_in 'Quantity', with: 5 # Line 16

      click_button 'Add Food' # Line 18

      expect(page).to have_content('Food was successfully created.')
      expect(page).to have_content('Apple')
    end
  end

  describe 'DELETE #destroy' do
    let!(:food) { create(:food, user: user) }

    it 'marks a food as deleted' do
      visit foods_path
      click_button "Delete_#{food.id}"
      expect(page).to have_content('Food was successfully "deleted".')
      expect(Food.last.is_deleted).to be_truthy
    end
  end
end
