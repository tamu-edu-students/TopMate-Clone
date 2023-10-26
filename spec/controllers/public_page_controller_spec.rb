# frozen_string_literal: true

RSpec.describe PublicPageController, type: :controller do
  describe 'GET #show' do
    it 'renders public page of valid user' do
      user = User.create(fname: 'John', lname: 'Doe', username: "jdoe", email: 'test@gmail.com', password: 'password')
      get :show, params: { username: user.username }
      expect(response).to render_template :user_public_page
      user.destroy
    end

    it 'renders user not found page of invalid user' do
      get :show, params: { username: 'invalid' }
      expect(response).to render_template :user_not_found
    end
  end
end
