require "spec_helper"

describe ClientsController do
  render_views
  let!(:client) { Fabricate(:client) }

  before do
    Resque.stub(:enqueue)
    Client.stub(:find_by_urn) { client }
  end

  describe "#index" do
    context "an authorized user", auth_controller: true do
      context "when a client exists" do
        before { get :index }

        it "renders index template" do
          response.should render_template(:index)
        end

        it_should_behave_like "a valid Microformats2 document"
      end

      context "with an associated location" do
        it "renders properly" do
          expect { get :index }.to_not raise_error
        end
      end
    end

    context "an unauthorized user" do
      it "redirects the user" do
        get :index
        expect(response).to be_redirect
      end
    end
  end

  describe "#show" do
    context "when the client exists" do
      before { get :show, id: client.urn }

      it "renders show template" do
        response.should render_template(:show)
      end

      it_should_behave_like "a valid Microformats2 document"
    end

    context "when no client exists" do
      it "explodes helpfully" do
        expect {
          get :show, id: "nonexistant"
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#new" do
    context "an authorized user", auth_controller: true do
      it "renders new template" do
        get :new
        response.should render_template(:new)
      end
    end

    context "an unauthorized user" do
      it "redirects the user" do
        get :new
        expect(response).to be_redirect
      end
    end
  end

  describe "#create" do
    context "an authorized user", auth_controller: true do
      it "renders new template when model is invalid" do
        Client.any_instance.stub(:valid?).and_return(false)
        post :create
        response.should render_template(:new)
      end

      it "enques webhooks and redirects when model is valid" do
        Client.any_instance.stub(:valid?).and_return(true)
        Client.any_instance.stub(:name).and_return("name")
        post :create

        expect(Resque).to have_received(:enqueue).
          with(WebhookPosterJob, Client.last.id, :post_configurator_webhook)

        expect(response.status).to eq 302
        expect(response).to redirect_to(client_path(Client.last))
      end
    end

    context "an unauthorized user" do
      it "redirects the user" do
        post :create
        expect(response).to be_redirect
      end
    end
  end

  describe "#edit" do
    context "an authorized user", auth_controller: true do
      it "renders edit template" do
        get :edit, id: 1
        response.should render_template(:edit)
      end
    end

    context "an unauthorized user" do
      it "redirects the user" do
        get :edit, id: 1
        expect(response).to be_redirect
      end
    end
  end

  describe "#update" do
    context "an authorized user", auth_controller: true do
      it "renders edit template when model is invalid" do
        client.stub(:valid?).and_return(false)
        put :update, id: 1
        response.should render_template(:edit)
      end

      it "enques webhooks and redirects when model is valid" do
        client.stub(:valid?).and_return(true)
        client.stub(:name).and_return("name")
        put :update, id: 1

        expect(Resque).to have_received(:enqueue).
          with(WebhookPosterJob, client.id, :post_client_update_webhooks)

        expect(response).to redirect_to(client_path)
      end

      context "allowed attributes" do
        it "accepts city param" do
          put :update, id: 1, client: { name: "Springfield" }
          expect(response.status).to eq 302
          expect(client.reload.name).to eq "Springfield"
        end

        it "rejects id param" do
          original_id = client.id
          put :update, id: 1, client: { id: original_id+1 }
          expect(response.status).to eq 302
          expect(client.reload.id).to eq original_id
        end
      end
    end

    context "an unauthorized user" do
      it "redirects the user" do
        put :update, id: 1
        expect(response).to be_redirect
      end
    end
  end

  describe "#destroy" do
    context "an authorized user", auth_controller: true do
      it "destroys" do
        client
        expect { delete :destroy, id: 1 }.to change(Client, :count).by(-1)
      end

      it "redirects" do
        delete :destroy, id: 1
        response.should redirect_to(clients_path)
      end
    end

    context "an unauthorized user" do
      it "redirects the user" do
        delete :destroy, id: 1
        expect(response).to be_redirect
      end
    end
  end
end
