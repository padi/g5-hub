require "spec_helper"

describe LocationsController do
  render_views

  describe "#show" do
    let!(:client) { Fabricate(:client) }
    let!(:location) { Fabricate(:location) }

    let(:client_urn) { client.urn }
    let(:location_urn) { location.urn }
    let(:request) { get :show, client_id: client_urn, id: location_urn }

    context "when the client and location exist" do
      before { request }

      it "renders show template" do
        response.should render_template(:show)
      end

      it_should_behave_like "a valid Microformats2 document"
    end

    context "when requesting a bad Client URN" do
      let(:client_urn) { "bad" }

      it "raises an ActiveRecord::RecordNotFound exception" do
        expect { request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when requesting a bad Location URN" do
      let(:location_urn) { "bad" }

      it "raises an ActiveRecord::RecordNotFound exception" do
        expect { request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
