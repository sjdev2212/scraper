require 'rails_helper'

RSpec.describe ScrapsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response for authenticated user' do
      # Assuming you have a User model created by Devise
      user = create(:user)
      sign_in user

      get :index
      expect(response).to be_successful
    end

    it 'renders the index template for authenticated user' do
      user = create(:user)
      sign_in user

      get :index
      expect(response).to render_template('index')
    end

    it 'redirects to sign in for unauthenticated user' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
