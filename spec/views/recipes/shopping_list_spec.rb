require 'rails_helper'

RSpec.feature 'Shopping List page', type: :feature do
  before(:each) do
    @user = create(:user)
    @food1 = create(:food, name: 'Food 1', price: 10)
    @food2 = create(:food, name: 'Food 2', price: 15)
    @food3 = create(:food, name: 'Food 3', price: 20)

    @stock_user = { 'Food 1' => 2, 'Food 3' => 5 }
    @foods_needed = { 'Food 1' => 3, 'Food 2' => 4, 'Food 3' => 8 }

    allow(Food).to receive(:find_by).with(any_args) do |name:|
      case name
      when 'Food 1' then double(price: 10)
      when 'Food 2' then double(price: 15)
      when 'Food 3' then double(price: 20)
      else double(price: 0)
      end
    end
  end

  scenario 'User views the shopping list' do
    login_as(@user, scope: :user)

    visit shopping_list_path

    expect(page).to have_content('Shopping List')

    expect(page).to have_content('Amount of food items to buy: 0')
    expect(page).to have_content('Total value of food needed: 0')

    expect(page).to have_selector('table')
  end
end
