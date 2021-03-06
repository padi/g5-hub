require "rails_helper"

describe LocationsController, auth_controller: true do
  render_views

  describe "#show" do
    let!(:client) { Fabricate(:client) }
    let!(:location) { Fabricate(:location, client: client) }

    let(:client_urn) { client.urn }
    let(:location_urn) { location.urn }
    let(:request) { get :show, client_id: client_urn, id: location_urn }

    context "json format" do
      before do
        get :show, client_id: client_urn, id: location_urn, format: :json
        @result = indifferent_hash response.body
      end

      specify { expect(@result['location']['id']).to eq(location.id) }
    end

    context "when the client and location exist" do
      before { request }

      it "renders show template" do
        expect(response).to render_template(:show)
      end

      it "decorates client" do
        expect(assigns(:client)).to be_decorated
      end

      it "decorates location" do
        expect(assigns(:location)).to be_decorated
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
