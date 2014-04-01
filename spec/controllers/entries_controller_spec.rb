require "spec_helper"

describe EntriesController do
  render_views
  let(:client) { Fabricate(:client) }
  before { Client.stub(:find_by_urn) { client } }


  describe "#index" do
    let(:request) { get :index }

    context "when a client exists" do
      before { request }

      it "renders index template" do
        response.should render_template(:index)
      end

      it_should_behave_like "a valid Microformats2 document"
    end
  end

  describe "#show" do
    before { get :show, id: 1 }

    it "renders show template" do
      response.should render_template(:show)
    end

    it_should_behave_like "a valid Microformats2 document"
  end
end
