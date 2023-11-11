# frozen_string_literal: true

# spec/controllers/dashboard_controller_spec.rb

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET #main' do
    context 'when the user is logged in' do
      it 'returns a successful response' do
        user = create(:user) # Create a user
        session[:user_id] = user.user_id
        get :main
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the user is not logged in' do
      it 'redirects to the login page' do
        get :main
        expect(response).to redirect_to(login_url)
      end
    end
  end

  describe 'before_action :is_logged_in' do
    context 'when the user is logged in' do
      it 'does not redirect' do
        user = create(:user)
        session[:user_id] = user.user_id
        get :main
        expect(response).not_to redirect_to(login_url)
      end
    end

    context 'when the user is not logged in' do
      it 'redirects to the login page' do
        get :main
        expect(response).to redirect_to(login_url)
      end
    end
  end
end
