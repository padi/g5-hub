require "spec_helper"

describe EntriesController do
  render_views
  let(:client) { Fabricate(:client) }
  before { Client.stub(:find_by_urn) { client } }
  let(:token) { double('token') }
  let(:valid) { false }

  context "api requests are protected by authenticatable api" do
    before do
      G5AuthenticatableApi::TokenValidator.any_instance.stub(
          access_token: token,
          valid?:       valid
      )
    end

    subject(:index) { get :index }

    context "without auth_token" do
      let(:token) {}

      it "should be redirected" do
        index
        expect(response.code).to eq('302')
      end
    end

    context "with invalid auth_token" do
      it "should return 401" do
        index
        expect(response.code).to eq('401')
      end
    end

    context "with valid auth_token" do
      let(:valid) { true }

      it "should be authenticated" do
        index
        expect(response.code).to eq('200')
      end
    end
  end

  context "with authenticated user", auth_controller: true do
    describe "#index" do
      context "json format" do
        let!(:client) { Fabricate(:client) }

        before do
          get :index, format: :json
          @result = indifferent_hash response.body
        end

        specify { @result['clients'].first['id'].should eq(client.id) }
      end

      context 'html format' do
        let(:request) { get :index }

        context "when a client exists" do
          before { request }

          it "renders index template" do
            response.should render_template(:index)
          end

          it_should_behave_like "a valid Microformats2 document"
        end
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
end
