require "spec_helper"

describe LocationsController do
  render_views
  let(:location) { Location.create(name: "Mock Location #{SecureRandom.hex}") }
  before { Location.stub!(:find_by_urn) { location } }

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
      Location.any_instance.stub(:valid?).and_return(false)
      post :create
      response.should render_template(:new)
    end
    it "redirects when model is valid" do
      Location.any_instance.stub(:valid?).and_return(true)
      Location.any_instance.stub(:name).and_return("name")
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
      Location.any_instance.stub(:valid?).and_return(false)
      put :update, id: 1
      response.should render_template(:edit)
    end
    it "redirects when model is valid" do
      Location.any_instance.stub(:valid?).and_return(true)
      Location.any_instance.stub(:name).and_return("name")
      put :update, id: 1 
      response.should redirect_to(clients_path)
    end
  end

  describe "#destroy" do
    it "destroys" do
      location
      expect { delete :destroy, id: 1 }.to change(Location, :count).by(-1)
    end
    it "redirects" do
      delete :destroy, id: 1
      response.should redirect_to(clients_path)
    end
  end
end
