# spec/controllers/home_controller_spec.rb

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) } # 创建一个测试用户对象

  describe '#current_user' do

    it 'does not assign a current user when not logged in' do
      # 模拟current_user方法返回nil，表示用户未登录
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

    it 'does not redirect when user is not logged in' do
      allow(controller).to receive(:current_user).and_return(nil)
      get :index
      expect(response).not_to redirect_to(dashboard_url)
    end
  end
end
