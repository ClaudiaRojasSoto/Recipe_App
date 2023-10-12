require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  describe 'GET /index' do
    it 'visits users#index' do
      sign_in user
      visit users_index_path
      expect(page).to have_content 'Find me in app/views/users/index.html.erb'
    end
  end
end
