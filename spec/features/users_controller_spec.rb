require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  let(:user) { create(:user) }

  before do
    # Autenticar al usuario
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  describe 'GET /index' do
    it 'visits users#index' do
      visit users_path
      expect(page).to have_content('algún contenido que esperas encontrar en la página')
    end
  end
end
