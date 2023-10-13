require 'rails_helper'

RSpec.describe "EditPublicPages", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/edit_public_page/index"
      expect(response).to have_http_status(:success)
    end
  end

end
