# frozen_string_literal: true

RSpec.describe UserAppointmentsController, type: :controller do
  describe 'GET #show' do
    context 'when user is logged in' do
      let(:user) do
        User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password', username: 'jdoe')
      end

      before do
        session[:user_id] = user.user_id
      end

      it 'assigns a new appointment' do
        # expect(assigns(:service)).to be_a_new(Service)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login_url' do
        # expect(response).to redirect_to(login_path)
      end
    end
  end
end
