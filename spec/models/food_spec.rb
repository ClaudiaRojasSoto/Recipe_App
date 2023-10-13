# spec/models/food_spec.rb

require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    food = build(:food, user: user)
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    food = build(:food, user: user, name: nil)
    expect(food).to_not be_valid
  end

  it 'is not valid without a measurement unit' do
    food = build(:food, user: user, measurement_unit: nil)
    expect(food).to_not be_valid
  end

  it 'is not valid without a price greater than 0' do
    food = build(:food, user: user, price: 0)
    expect(food).to_not be_valid
  end

  it 'is not valid without a quantity greater than 0' do
    food = build(:food, user: user, quantity: 0)
    expect(food).to_not be_valid
  end

  describe 'obtener precio' do
    it 'returns the price for a valid food name' do
      create(:food, user: user, name: 'Example Food', price: 5.0)
      price = Food.obtener_precio('Example Food')
      expect(price).to eq(5.0)
    end

    it 'returns 0 for an invalid food name' do
      price = Food.obtener_precio('Nonexistent Food')
      expect(price).to eq(0)
    end
  end
end
