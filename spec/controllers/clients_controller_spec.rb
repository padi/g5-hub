require "spec_helper"

describe ClientsController do
  render_views
  let(:client) { Client.create(name: "Mock Client #{SecureRandom.hex}") }
  before { Client.stub!(:find_by_urn) { client } }

  describe "#index" do
    it "renders index template" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "#show" do
    it "renders show template" do
      get :show, id: 1
      response.should render_template(:show)
    end
  end

  describe "#new" do
    it "renders new template" do
      get :new
      response.should render_template(:new)
    end

    context "with an associated location" do
      it "renders properly" do
        expect { get :index }.to_not raise_error
  context "when a client exists" do
    describe "#index" do
      let(:response_node) { Capybara.string(response.body) }

      it "renders index template" do
        get :index
        response.should render_template(:index)
      end

      it "links correctly to the client" do
        get :index
        response_node.find(".e-g5-client a.u-uid")["href"].should eq("http://test.host/clients/g5-c-1-older")
      end

      it "includes the expected Last-Modified header" do
        get :index
        response.headers["Last-Modified"].should eq("Tue, 01 Jan 2013 00:00:00 GMT")
      end
    end
  end

  describe "#create" do
    it "renders new template when model is invalid" do
      Client.any_instance.stub(:valid?).and_return(false)
      post :create
      response.should render_template(:new)
    end
    it "redirects when model is valid" do
      Client.any_instance.stub(:valid?).and_return(true)
      Client.any_instance.stub(:name).and_return("name")
      post :create
      response.should redirect_to(clients_path)
    end
  end

  describe "#edit" do
    it "renders edit template" do
      get :edit, id: 1
      response.should render_template(:edit)
    end
  end

  describe "#update" do
    it "renders edit template when model is invalid" do
      Client.any_instance.stub(:valid?).and_return(false)
      put :update, id: 1
      response.should render_template(:edit)
      context "when there are multiple clients" do
        it "orders the clients correctly" do
          get :index
          assigns(:clients).map(&:name).should eq([ "Newer", "Older" ])
        end
      end

      context "with an associated location" do
        it "renders properly" do
          expect { get :index }.to_not raise_error
        end

        it "links correctly to the location" do
          get :index
          response_node.find(".e-g5-location a.u-uid")["href"].should eq("http://test.host/locations/g5-cl-1-test-location")
        end
      end
    end
    it "redirects when model is valid" do
      Client.any_instance.stub(:valid?).and_return(true)
      Client.any_instance.stub(:name).and_return("name")
      put :update, id: 1
      response.should redirect_to(clients_path)
    end
  end

  describe "#destroy" do
    it "destroys" do
      client
      expect { delete :destroy, id: 1 }.to change(Client, :count).by(-1)
    end
    it "redirects" do
      delete :destroy, id: 1
      response.should redirect_to(clients_path)
    end
  end
end
