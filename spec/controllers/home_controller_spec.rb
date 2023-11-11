# frozen_string_literal: true

# spec/controllers/home_controller_spec.rb

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) }

  describe '#current_user' do
    it 'does not assign a current user when not logged in' do
      allow(controller).to receive(:current_user).and_return(nil)

      get :index

      expect(assigns(:current_user)).to be_nil
    end
  end

  describe '#require_login' do
    it 'does not redirect when user is logged in' do
      allow(controller).to receive(:current_user).and_return(user)
      get :index
      expect(response).not_to redirect_to(login_url)
    end
  end

  describe '#is_logged_in' do
    it 'redirects to dashboard page when user is logged in' do
      allow(controller).to receive(:current_user).and_return(user)
      get :index
      expect(response).to redirect_to(dashboard_url)
    end
  end
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
