require "rails_helper"

RSpec.describe HoursController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/hours").to route_to("hours#index")
    end

    it "routes to #new" do
      expect(get: "/hours/new").to route_to("hours#new")
    end

    it "routes to #show" do
      expect(get: "/hours/1").to route_to("hours#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/hours/1/edit").to route_to("hours#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/hours").to route_to("hours#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/hours/1").to route_to("hours#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/hours/1").to route_to("hours#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/hours/1").to route_to("hours#destroy", id: "1")
    end
  end
end
