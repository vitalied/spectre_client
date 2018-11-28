require "rails_helper"

RSpec.describe ConnectionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/connections").to route_to("connections#index")
    end

    it "routes to #new" do
      expect(get: "/connections/new").to route_to("connections#new")
    end

    it "routes to #reconnect" do
      expect(get: "/connections/1/reconnect").to route_to("connections#reconnect", id: "1")
    end

    it "routes to #refresh" do
      expect(get: "/connections/1/refresh").to route_to("connections#refresh", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/connections/1").to route_to("connections#destroy", id: "1")
    end
  end
end
