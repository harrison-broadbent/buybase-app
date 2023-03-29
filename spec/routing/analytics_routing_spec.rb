require "rails_helper"

RSpec.describe AnalyticsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/analytics").to route_to("analytics#index")
    end

    it "routes to #new" do
      expect(get: "/analytics/new").to route_to("analytics#new")
    end

    it "routes to #show" do
      expect(get: "/analytics/1").to route_to("analytics#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/analytics/1/edit").to route_to("analytics#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/analytics").to route_to("analytics#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/analytics/1").to route_to("analytics#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/analytics/1").to route_to("analytics#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/analytics/1").to route_to("analytics#destroy", id: "1")
    end
  end
end
