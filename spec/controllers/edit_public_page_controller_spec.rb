# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EditPublicPageController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    it 'redirects to login page when user is not logged in' do
      session[:user_id] = nil # Simulate not being logged in
      get :index
      expect(response).to redirect_to(login_url)
    end

    it 'assigns current user when logged in' do
      session[:user_id] = user.user_id # Simulate being logged in
      get :index
      expect(assigns(:current_user)).to eq(user)
    end
  end

  describe '#update' do
    it 'redirects to login page when user is not logged in' do
      session[:user_id] = nil # Simulate not being logged in
      post :update, params: { user: { fname: 'John' } }
      expect(response).to redirect_to(login_url)
    end

    it 'updates user and redirects when logged in' do
      session[:user_id] = user.user_id # Simulate being logged in
      expect(User).to receive(:find_by).with(user_id: user.user_id).and_return(user)
      expect(user).to receive(:update).and_return(true)
      post :update, params: { user: { fname: 'John' } }
      expect(response).to redirect_to(edit_public_page_path)
    end
  end
end
