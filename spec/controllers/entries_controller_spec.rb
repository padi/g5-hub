require "spec_helper"

describe EntriesController do
  render_views
  let(:client) { Fabricate(:client) }
  before { Client.stub!(:find_by_urn) { client } }


  describe "#index" do
      let(:response_node) { Capybara.string(response.body) }
    context "when a client exists" do
      it "renders index template" do
        get :index
        response.should render_template(:index)
      end
    end

    context "with an associated location" do
      it "renders properly" do
        expect { get :index }.to_not raise_error
      end
    end
  end

  describe "#show" do
    it "renders show template" do
      get :show, id: 1
      response.should render_template(:show)
    end
  end
end
