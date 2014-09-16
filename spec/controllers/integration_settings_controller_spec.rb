require 'spec_helper'

describe IntegrationSettingsController do
  let!(:location) { Fabricate(:location, client: Fabricate(:client)) }
  let(:integration_setting) { Fabricate(:integration_setting, location: location) }

  describe 'GET new' do
    describe :success do
      before do
        get :new, location_id: location.id
      end

      specify { expect(response.status).to eq(200) }
      specify { expect(response).to render_template(:new) }
      specify { expect(assigns(:integration_setting).id).to be_nil }
    end
    describe :failure do
      it 'handles location not found' do
        expect { get :new, location_id: 'madeup' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET edit' do
    describe :success do
      before do
        get :edit, location_id: location.id, id: integration_setting.id
      end

      specify { expect(response.status).to eq(200) }
      specify { expect(response).to render_template(:edit) }
      specify { expect(assigns(:integration_setting).id).to eq(integration_setting.id) }
    end
    describe :failure do
      it 'handles location not found' do
        expect { get :edit, location_id: 'madeup', id: 'whateva' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST create' do
    describe :success do
      before do
        post :create, location_id: location.urn, integration_setting: Fabricate.attributes_for(:integration_setting)
      end

      specify { expect(response).to redirect_to(client_url(location.client)) }
      specify { expect(subject.request.flash.notice).to eq('Successfully created integration setting') }
    end
    describe :failure do
      before do
        post :create, location_id: location.urn, integration_setting: {inventory_service_url: ''}
      end
      specify { expect(response).to render_template(:new) }
    end
  end

  describe 'PUT update' do
    describe :success do
      before do
        put :update, location_id: location, id: integration_setting, integration_setting: {etl_strategy_name: 'offense'}
      end

      specify { expect(response).to redirect_to(client_url(location.client)) }
      specify { expect(subject.request.flash.notice).to eq('Successfully updated integration setting') }
    end
    describe :failure do
      before do
        put :update, location_id: location.urn, id: integration_setting, integration_setting: {inventory_service_url: ''}
      end
      specify { expect(response).to render_template(:edit) }
    end
  end
end