# frozen_string_literal: true
# RSpec.describe SessionsController, type: :controller do
#     describe "POST #create" do
#       let(:user) { create(:user, password: "password") }

#       context "with valid credentials" do
#         it "redirects to the home page and sets the session" do
#           post :create, params: { email: user.email, password: "password" }
#           expect(response).to redirect_to(root_path)
#           expect(session[:user_id]).to eq(user.id)
#           expect(flash[:success]).to be_present
#         end
#       end

#       context "with invalid credentials" do
#         it "renders the login page with an error message" do
#           post :create, params: { email: user.email, password: "wrong_password" }
#           expect(response).to redirect_to(sessions_new_path)
#           expect(session[:user_id]).to be_nil
#           expect(flash[:error]).to be_present
#         end
#       end
#     end

#     describe "DELETE #destroy" do
#       let(:user) { create(:user) }

#       before do
#         session[:user_id] = user.id
#       end

#       it "redirects to the login page and clears the session" do
#         delete :destroy
#         expect(response).to redirect_to(login_path)
#         expect(session[:user_id]).to be_nil
#         expect(flash[:success]).to be_present
#       end
#     end
#   end
