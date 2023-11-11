# frozen_string_literal: true

# spec/controllers/home_controller_spec.rb

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    context 'when the user is logged in' do
      it 'redirects to the dashboard page' do
        user = create(:user) # Create a user
        session[:user_id] = user.user_id
        get :index
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'when the user is not logged in' do
      it 'returns a successful response' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
