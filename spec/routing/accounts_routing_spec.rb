require "rails_helper"

RSpec.describe AccountsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/accounts").to route_to("accounts#index")
    end
  end
end
