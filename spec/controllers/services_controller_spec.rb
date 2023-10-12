RSpec.describe ServicesController, type: :controller do
  describe "GET #new" do
    context "when user is logged in" do
      let(:user) { User.create(fname: "John", lname: "Doe", email: "test@example.com", password: "password") }
      
      before do
        session[:user_id] = user.user_id
        get :new
      end
      
      it "assigns a new service" do
        expect(assigns(:service)).to be_a_new(Service)
      end
    end
    
    context "when user is not logged in" do
      before { get :new }
      
      it "redirects to login_url" do
        expect(response).to redirect_to(login_path)
      end
    end
  end
  
  describe "POST #create" do
    let(:user) { User.create(fname: "John", lname: "Doe", email: "test@example.com", password: "password") }
    
    context "when user is logged in" do
      before { session[:user_id] = user.user_id }
      
      context "with valid parameters" do
        let(:valid_params) { { service: { name: "Test Service", description: "test service description", price: 120, duration:10 } } }
        
        it "creates a new service" do
          expect {
            post :create, params: valid_params
          }.to change(Service, :count).by(1)
        end
        
        it "redirects to root_path" do
          post :create, params: valid_params
          expect(response).to redirect_to(root_path)
        end
        
        it "sets a success notice" do
          post :create, params: valid_params
          expect(flash[:notice]).to eq("Service created successfully.")
        end
      end
    end
    
    context "when user is not logged in" do
      before { post :create }
      
      it "redirects to login_url" do
        expect(response).to redirect_to(login_path)
      end
    end
  end
  
  describe "GET #index" do
    context "when user is logged in" do
      let(:user) { User.create(fname: "John", lname: "Doe", email: "test@example.com", password: "password") }
      let!(:service1) { user.services.create(name: "Test Service1", description: "test service1 description", price: 120, duration:10) }
      let!(:service2) { user.services.create(name: "Test Service2", description: "test service2 description", price: 20, duration:20) }
      
      before do
        session[:user_id] = user.user_id
        get :index
      end
      
      it "assigns the user's services" do
        expect(assigns(:services)).to eq([service1, service2])
      end
      
      it "renders the index template" do
        expect(response).to render_template(:index)
      end
    end
    
    context "when user is not logged in" do
      before { get :index }
      
      it "redirects to login_url" do
        expect(response).to redirect_to(login_path)
      end
    end
  end
end