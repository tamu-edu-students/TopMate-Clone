# spec/controllers/edit_public_page_controller_spec.rb

require 'rails_helper'

RSpec.describe EditPublicPageController, type: :controller do
  let(:user) { create(:user) } # 创建一个测试用户对象

  describe '#index' do
    it 'redirects to login page when user is not logged in' do
      allow(controller).to receive(:current_user).and_return(nil)
      get :index
      expect(response).to redirect_to(login_url)
    end

    it 'assigns current user when logged in' do
      allow(controller).to receive(:current_user).and_return(user)
      get :index
      expect(assigns(:current_user)).to eq(user)
    end
  end

  describe '#update' do
    it 'redirects to login page when user is not logged in' do
      allow(controller).to receive(:current_user).and_return(nil)
      post :update, params: { user: { fname: 'John' } }
      expect(response).to redirect_to(login_url)
    end

    it 'updates user and redirects when logged in' do
      allow(controller).to receive(:current_user).and_return(user)
      expect(user).to receive(:update).and_return(true)
      post :update, params: { user: { fname: 'John' } }
      expect(response).to redirect_to(edit_public_page_path)
    end

    it 'renders edit page and sets flash error on update failure' do
      allow(controller).to receive(:current_user).and_return(user)
      expect(user).to receive(:update).and_return(false)
      post :update, params: { user: { fname: 'John' } }
      expect(response).to render_template(:index)
      expect(flash[:error]).to be_present
    end
  end
end
