require 'rails_helper'

RSpec.describe 'foods/index', type: :view do
  let(:user) { TestConfiguration.create_example_user }

  before do
    assign(:user, user)
    assign(:foods, [Food.new(name: 'Pizza', measurement_unit: 'Slice', price: 10, quantity: 2)])
    render
  end

  it 'renders a list of foods' do
    expect(rendered).to match(/Pizza/)
    expect(rendered).to match(/Slice/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/2/)
  end

  it 'renders Add New Food button' do
    expect(rendered).to have_selector('.add-food-button', text: 'Add Food')
  end
end
