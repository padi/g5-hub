require "spec_helper"

describe ClientsController do
  render_views
  let(:client) { Fabricate(:client) }
  before { Client.stub(:find_by_urn) { client } }


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

  describe "#new" do
    it "renders new template" do
      get :new
      response.should render_template(:new)
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
      client.stub(:valid?).and_return(false)
      put :update, id: 1
      response.should render_template(:edit)
    end
    it "redirects when model is valid" do
      client.stub(:valid?).and_return(true)
      client.stub(:name).and_return("name")
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
