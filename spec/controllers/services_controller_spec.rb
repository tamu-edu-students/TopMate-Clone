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
      user.services.create(name: 'Test Service1', short_description: 'test service1 description', price: 120,
                           duration: 10)
    end

    context 'when user is logged in' do
      before { session[:user_id] = user.user_id }

      it 'hides the service and displays a success message' do
        delete :hide, params: { id: service.id }
        service.reload

        expect(service.hidden).to eq(true)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }

    context 'when user is logged in' do
      before { session[:user_id] = user.user_id }

      context 'with valid parameters' do
        let(:valid_params) do
          { service: { name: 'Test Service', short_description: 'test service description', price: 120, duration: 10 } }
        end

        it 'creates a new service' do
          expect do
            post :create, params: valid_params
          end.to change(Service, :count).by(1)
        end

        it 'redirects to services index' do
          post :create, params: valid_params
          expect(response).to redirect_to(servicesindex_path)
        end

        it 'sets a success notice' do
          post :create, params: valid_params
          expect(flash[:notice]).to eq('Service was successfully created.')
        end
      end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { service: { name: '', short_description: '', price: nil, duration: nil } }
      end

      it 'renders the new template with unprocessable entity status' do
        post :create, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end

      it 'assigns the invalid service to @service' do
        post :create, params: invalid_params

        expect(assigns(:service)).to be_a_new(Service)
        expect(assigns(:service).errors.any?).to be_truthy
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
    let(:service) {Service.create(name: 'Test Service', short_description: 'test service description', price: 120, duration: 10)}

    context 'when user is logged in' do
      before { session[:user_id] = user.user_id }

      context 'with valid parameters' do
        let(:valid_params) do
          { service: { name: 'Test Service new', short_description: 'test service description new', price: 12,
                       duration: 1 } }
        end

        it 'edits an existing service' do
          expect do
            post :create, params: valid_params
          end
        end

        it 'redirects to services index' do
          post :create, params: valid_params
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

  describe 'GET #index' do
    context 'when user is logged in' do
      let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }
      let!(:service1) do
        user.services.create(name: 'Test Service1', short_description: 'test service1 description', price: 120,
                             duration: 10)
      end
      let!(:service2) do
        user.services.create(name: 'Test Service2', short_description: 'test service2 description', price: 20,
                             duration: 20)
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

describe 'POST #submit_edit' do
    let(:user) { FactoryBot.create(:user) }
    context 'when user is logged in' do
      before do
         session[:user_id] = user.user_id
      end
    context 'the service exists' do
      let(:service) { FactoryBot.create(:service, user: user) }

      it 'updates the service and redirects to services index' do
        post :submit_edit, params: { token: service.id, service: { name: 'Updated Service' } }
        service_res=Service.find_by_id(service.id)
        expect(service_res.name).to eq('Updated Service')
        expect(response).to redirect_to(servicesindex_url)
      end
    end

    context 'when the service does not exist' do
      it 'renders a plain text response and sets a flash error message' do
        post :submit_edit, params: { token: 'nonexistent_token', service: { name: 'Updated Service' } }
        expect(response.body).to eq('Service does not exist.')
        expect(flash[:error]).to eq('Service not found')
      end
    end

    context 'when the service update fails' do
      let(:service) { FactoryBot.create(:service, user: user) }

      it 'redirects back with a flash error message' do
        allow_any_instance_of(Service).to receive(:update).and_return(false)
        post :submit_edit, params: { token: service.id, service: { name: 'Updated Service' } }
        expect(flash[:error]).to eq('Failed to update service')
        expect(response).to redirect_to(root_path)
      end
    end
  end
  end


  describe 'POST #togglepublish' do
    let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }

    context 'when user is logged in' do
      before { session[:user_id] = user.user_id }

      context 'session is not published' do
        let(:service) do
          user.services.create(name: 'Service', short_description: 'desc', price: 0, duration: 0, is_published: false)
        end
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
        let(:service) do
          user.services.create(name: 'Service', short_description: 'desc', price: 0, duration: 0, is_published: true)
        end
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
