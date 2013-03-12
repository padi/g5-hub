require "spec_helper"

describe EntriesController do
  render_views

  context "when no clients exist" do
    describe "#index" do
      it "doesn't blow up" do
        get :index
        response.should render_template(:index)
      end
    end

    describe "#show" do
      it "blows up with the expected exception" do
        exception = FoundationClient::RecordNotFoundException
        expect { get :show, id: "g5-c-1-foo" }.to raise_error(exception)
      end
    end
  end

  context "when a client exists" do
    before do
      foundation_database.add(
        FoundationClient::Client.new(
          id: 1,
          name: "Older",
          created_at: Time.parse("1-1-2013 00:00 UTC"),
          updated_at: Time.parse("1-1-2013 00:00 UTC")
        )
      )
    end

    describe "#index" do
      let(:response_node) { Capybara.string(response.body) }

      it "renders index template" do
        get :index
        response.should render_template(:index)
      end

      it "links correctly to the client" do
        get :index
        actual = response_node.find(".h-entry .e-content div.h-card a.u-uid")["href"]
        expected = "http://test.host/clients/g5-c-1-older"
        actual.should eq actual
      end

      it "includes the expected Last-Modified header" do
        get :index
        actual = response.headers["Last-Modified"]
        expected = "Tue, 01 Jan 2013 00:00:00 GMT"
        actual.should eq expected
      end

      context "when there are multiple clients" do
        before do
          foundation_database.add(
            FoundationClient::Client.new(
              id: 1,
              name: "Newer",
              created_at: Time.parse("2-2-2013 00:00"),
              updated_at: Time.parse("2-2-2013 00:00")
            )
          )
        end

        it "orders the clients correctly" do
          get :index
          assigns(:clients).map(&:name).should eq(["Newer", "Older"])
        end
      end

      context "with an associated location" do
        before do
          foundation_database.add(
            FoundationClient::Location.new(
              name: "Test Location",
              client_id: 1
            )
          )
        end

        it "renders properly" do
          expect { get :index }.to_not raise_error
        end

        it "links correctly to the location" do
          get :index
          actual = response_node.find(".h-entry .e-content div.h-card a.p-org.h-card")["href"]
          expected = "http://test.host/clients/g5-c-1-older/locations/g5-cl-1-test-location"
          actual.should eq expected
        end
      end
    end

    describe "#show" do
      it "renders show template" do
        get :show, id: "g5-c-1-foo"
        response.should render_template(:show)
      end
    end
  end
end
