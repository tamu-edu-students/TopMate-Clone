# frozen_string_literal: true

RSpec.describe UserAppointmentsController, type: :controller do
  describe '#show' do
  let(:user) { create(:user, username: 'testuser') }
  let(:service) { create(:service, hidden: false, is_published: true) }
  let(:appointment) { create(:appointment, service_id: service.id, user_id: user.user_id) }

    context 'when user exists and is logged in' do
      before do
        session[:user_id] = user.user_id
        get :show, params: { username: user.username }
      end

      it 'assigns the current user' do
        expect(assigns(:current_user)).to eq(user)
      end

      it 'assigns the username' do
        expect(assigns(:username)).to eq(user.username)
      end

      it 'assigns the user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'assigns the services' do
        expect(assigns(:services)).to include(service)
      end

      it 'assigns the appointments' do
        expect(assigns(:appointments)).to include(appointment)
      end

      it 'renders the index template' do
        expect(response).to render_template('user_appointments/index')
      end
    end

    context 'when user does not exist' do
      before do
        get :show, params: { username: 'nonexistent_user' }
      end

      it 'renders the user_not_found template' do
        expect(response).to render_template('user_appointments/user_not_found')
      end
    end

    context 'when user is not logged in' do
      before do
        get :show, params: { username: user.username }
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to(login_url)
      end
    end
  end
end
