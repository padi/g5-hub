require "spec_helper"

describe LocationsController do
  render_views
  let(:client) { Fabricate(:client) }
  before { Client.stub!(:find_by_urn) { client } }
  let(:location) { Fabricate(:location) }
  before { Location.stub!(:find_by_urn) { location } }

  describe "#show" do
    it "renders show template" do
      get :show, client_id: 1, id: 1
      response.should render_template(:show)
    end
  end
end
