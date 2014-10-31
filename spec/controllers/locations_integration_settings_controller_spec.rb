require 'rails_helper'

describe LocationsIntegrationSettingsController, auth_controller: true do
  let(:clients_integration_setting) { Fabricate(:clients_integration_setting).tap { |cis| cis.integration_setting.create_job_setting(Fabricate.to_params(:job_setting)) } }
  let(:locations_integration_setting) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }

  describe 'GET show' do
    subject do
      get :show, client_id: locations_integration_setting.clients_integration_setting.client.urn, location_id: locations_integration_setting.location.urn, id: locations_integration_setting.urn, format: :json
      indifferent_hash(response.body)[:locations_integration_setting]
    end

    its([:urn]) { is_expected.to eq(locations_integration_setting.urn) }
  end

  describe 'GET edit' do
    before do
      get :edit, id: locations_integration_setting.id
    end

    it 'renders correct template' do
      expect(response).to render_template(:edit)
    end

    it 'builds an integration setting' do
      expect(assigns(:locations_integration_setting).integration_setting).to_not be_nil
      expect(assigns(:locations_integration_setting).integration_setting.job_setting).to_not be_nil
    end
  end

  describe 'PUT update' do
    describe 'success' do
      let(:strategy_name) { 'foo' }
      before do
        put :update, id: locations_integration_setting.id, locations_integration_setting: {integration_setting_attributes: {strategy_name: strategy_name, vendor_endpoint: nil, override: true}}
      end

      it 'redirect' do
        expect(response).to redirect_to(clients_integration_setting_url(locations_integration_setting.clients_integration_setting))
      end

      it 'saves update' do
        expect(assigns(:locations_integration_setting).integration_setting.strategy_name).to eq(strategy_name)
      end
    end
  end
end