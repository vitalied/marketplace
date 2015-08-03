require "rails_helper"

RSpec.describe QuoteRequestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/quotes").to route_to("quote_requests#index")
    end

    it "routes to #new" do
      expect(get: "/quotes/new").to route_to("quote_requests#new")
    end

    it "routes to #create" do
      expect(post: "/quotes").to route_to("quote_requests#create")
    end

  end
end
