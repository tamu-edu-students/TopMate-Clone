# spec/controllers/hours_controller_spec.rb
"""
require 'rails_helper'

RSpec.describe HoursController, type: :controller do
  describe 'GET #index' do
    context 'when the user is logged in' do
      let(:user) { create(:user) }

      before { allow(controller).to receive(:find_current_user) { user } }

      it 'assigns the current user' do
        get :index
        expect(assigns(:current_user)).to eq(user)
      end

      it 'retrieves and sorts the user\'s hours' do
        hours = create_list(:hour, 5, user: user)
        get :index
        expect(assigns(:days)).to be_an(Array)
        expect(assigns(:days).size).to eq(7)
        expect(assigns(:days)[hours.first.day]).to eq([hours.first])
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'when the user is not logged in' do
      before { allow(controller).to receive(:find_current_user) { nil } }

      it 'redirects to the login page' do
        get :index
        expect(response).to redirect_to(login_url)
      end
    end
  end

  describe 'GET #new' do
    let(:user) { create(:user) }

    before { allow(controller).to receive(:find_current_user) { user } }

    it 'assigns a new hour instance' do
      get :new
      expect(assigns(:hour)).to be_a_new(Hour)
    end

    it 'assigns a list of days' do
      get :new
      expect(assigns(:days)).to be_an(Array)
      expect(assigns(:days).size).to eq(7)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:valid_params) do
      {
        hour: {
          day: 1,             # Replace with valid day value
          start_time: '09:00', # Replace with valid start time
          end_time: '17:00'    # Replace with valid end time
        }
      }
    end

    before { allow(controller).to receive(:find_current_user) { user } }

    context 'with valid parameters' do
      it 'creates a new hour' do
        expect {
          post :create, params: valid_params
        }.to change(Hour, :count).by(1)
      end

      it 'assigns the new hour' do
        post :create, params: valid_params
        expect(assigns(:hour)).to be_a(Hour)
        expect(assigns(:hour)).to be_persisted
      end

      it 'redirects to the hour show page' do
        post :create, params: valid_params
        expect(response).to redirect_to(hour_url(assigns(:hour)))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          hour: {
            day: 8,             # Invalid day value
            start_time: '09:00', # Valid start time
            end_time: '08:00'    # End time earlier than start time
          }
        }
      end

      it 'does not create a new hour' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Hour, :count)
      end

      it 'assigns an invalid hour' do
        post :create, params: invalid_params
        expect(assigns(:hour)).to be_a(Hour)
        expect(assigns(:hour)).not_to be_persisted
      end

      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template('new')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:hour) { create(:hour, user: user) }

    before { allow(controller).to receive(:find_current_user) { user } }

    it 'destroys the requested hour' do
      hour # Ensure the hour exists
      expect {
        delete :destroy, params: { id: hour.to_param }
      }.to change(Hour, :count).by(-1)
    end

    it 'redirects to the hours list' do
      delete :destroy, params: { id: hour.to_param }
      expect(response).to redirect_to(hours_url)
    end
  end
end
"""