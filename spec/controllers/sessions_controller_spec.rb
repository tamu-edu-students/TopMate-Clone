# frozen_string_literal: true

RSpec.describe SessionsController, type: :controller do
    describe "POST #create" do
      let(:user) { create(:user, password: "password") }

      context "with valid credentials" do
        it "redirects to the home page and sets the session" do
          post :create, params: { email: user.email, password: "password" }
          expect(response).to redirect_to(dashboard_path)
          expect(session[:user_id]).to eq(user.id)
          expect(flash[:notice]).to be_present
        end
      end

      context "with invalid credentials" do
        it "renders the login page with an error message" do
          post :create, params: { email: user.email, password: "wrong_password" }
          expect(response).to redirect_to(sessions_new_path)
          expect(session[:user_id]).to be_nil
          expect(flash[:error]).to be_present
        end
      end
    end

    describe 'DELETE #destroy' do
      let(:user) { create(:user) }

      before do
        session[:user_id] = user.id
      end

    it "redirects to the root page and clears the session" do
      delete :destroy
      expect(response).to redirect_to(root_url)
      expect(session[:user_id]).to be_nil
      expect(flash[:notice]).to be_present
    end

    context 'when no user is logged in' do
      before do
        session[:user_id] = nil
        delete :destroy
      end

      it 'redirects to the root page' do
        expect(response).to redirect_to(root_url)
      end
    end
  end

    describe '#redirect_if_logged_in' do
    context 'when user is logged in' do
      let(:user) { create(:user) }

      before do
        session[:user_id] = user.user_id
        get :new
      end

      it 'redirects to the dashboard page' do
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'when user is not logged in' do
      before do
        get :new
      end

      it 'does not redirect' do
        expect(response).not_to have_http_status(:redirect)
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#price_is_valid_precision' do
    context 'when price has too many decimal places' do
      let(:service) { build(:service, price: 12.345) }

      it 'adds an error to the price attribute' do
        service.valid?
        expect(service.errors[:price]).to include('is invalid. Too many decimal places.')
      end
    end

    context 'when price has valid precision' do
      let(:service) { build(:service, price: 12.34) }

      it 'does not add an error to the price attribute' do
        service.valid?
        expect(service.errors[:price]).to be_empty
      end
    end
  end
  end
