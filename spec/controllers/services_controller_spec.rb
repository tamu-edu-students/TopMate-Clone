# frozen_string_literal: true

RSpec.describe ServicesController, type: :controller do
  describe 'GET #new' do
    context 'when user is logged in' do
      let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }

      before do
        session[:user_id] = user.user_id
        get :new
      end

      it 'assigns a new service' do
        expect(assigns(:service)).to be_a_new(Service)
      end
    end

    context 'when user is not logged in' do
      before { get :new }

      it 'redirects to login_url' do
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'DELETE #hide' do
    let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }
    let!(:service) do
      user.services.create(name: 'Test Service1', description: 'test service1 description', price: 120, duration: 10)
    end
    it 'hides the service and displays a success message' do
      delete :hide, params: { id: service.id }
      service.reload

      expect(service.hidden).to eq(true)
    end
  end

  describe 'POST #create' do
    let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }

    context 'when user is logged in' do
      before { session[:user_id] = user.user_id }

      context 'with valid parameters' do
        let(:valid_params) do
          { service: { name: 'Test Service', description: 'test service description', price: 120, duration: 10 } }
        end

        it 'creates a new service' do
          expect do
            post :create, params: valid_params
          end.to change(Service, :count).by(1)
        end

        it 'redirects to root_path' do
          post :create, params: valid_params
          expect(response).to redirect_to(root_path)
        end

        it 'sets a success notice' do
          post :create, params: valid_params
          expect(flash[:notice]).to eq('Service created successfully.')
        end
      end
    end

    context 'when user is not logged in' do
      before { post :create }

      it 'redirects to login_url' do
        expect(response).to redirect_to(login_path)
      end
    end
  end
  describe 'POST #edit' do
    let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }
    let(:service) do
      Service.create(name: 'Test Service', description: 'test service description', price: 120, duration: 10)
    end

    context 'when user is logged in' do
      before { session[:user_id] = user.user_id }

      context 'with valid parameters' do
        let(:valid_params) do
          { service: { name: 'Test Service new', description: 'test service description new', price: 12, duration: 1 } }
        end

        it 'edits an existing service' do
          expect do
            post :create, params: valid_params
          end
        end

        it 'redirects to root_path' do
          post :create, params: valid_params
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when user is not logged in' do
      before { post :create }

      it 'redirects to login_url' do
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #index' do
    context 'when user is logged in' do
      let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }
      let!(:service1) do
        user.services.create(name: 'Test Service1', description: 'test service1 description', price: 120, duration: 10)
      end
      let!(:service2) do
        user.services.create(name: 'Test Service2', description: 'test service2 description', price: 20, duration: 20)
      end

      before do
        session[:user_id] = user.user_id
        get :index
      end

      it "assigns the user's services" do
        expect(assigns(:services)).to eq([service1, service2])
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not logged in' do
      before { get :index }

      it 'redirects to login_url' do
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST #togglepublish' do
    let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }

    context 'when user is logged in' do
      before { session[:user_id] = user.user_id }

      context 'session is not published' do
        let(:service) { user.services.create(name: '', description: '', price: 0, duration: 0, is_published: false) }
        let(:valid_params) do
          { id: service.id }
        end

        it 'sets is_published to true' do
          post :togglepublish, params: valid_params
          expect(Service.find_by(id: service.id).is_published).to eq(true)
        end

        it 'redirects to root_path' do
          post :togglepublish, params: valid_params
          expect(response).to redirect_to(servicesindex_path)
        end
      end

      context 'session is published' do
        let(:service) { user.services.create(name: '', description: '', price: 0, duration: 0, is_published: true) }
        let(:valid_params) do
          { id: service.id }
        end

        it 'sets is_published to false' do
          post :togglepublish, params: valid_params
          expect(Service.find_by(id: service.id).is_published).to eq(false)
        end

        it 'redirects to root_path' do
          post :togglepublish, params: valid_params
          expect(response).to redirect_to(servicesindex_path)
        end
      end
    end

    context 'when user is not logged in' do
      before { post :create }

      it 'redirects to login_url' do
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
