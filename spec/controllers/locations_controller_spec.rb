require "spec_helper"

describe LocationsController do
  render_views
  let(:client) { Client.create(name: "Mock Client #{SecureRandom.hex}", vertical: "Apartments") }
  before { Client.stub!(:find_by_urn) { client } }
  let(:location) { Location.create(name: "Mock Location #{SecureRandom.hex}") }
  before { Location.stub!(:find_by_urn) { location } }

  describe "#show" do
    it "renders show template" do
      get :show, client_id: 1, id: 1
      response.should render_template(:show)
    end
  end
end
