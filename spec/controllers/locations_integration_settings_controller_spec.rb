require 'spec_helper'

describe LocationsIntegrationSettingsController, auth_controller: true do
  let(:locations_integration_setting) { Fabricate(:locations_integration_setting) }

  describe 'GET edit' do
    before do
      get :edit, id: locations_integration_setting.id
    end

    it 'renders correct template' do
      response.should render_template(:edit)
    end

    it 'builds an integration setting' do
      assigns(:locations_integration_setting).integration_setting.should_not be_nil
    end
  end

  describe 'PUT update' do
    describe 'success' do
      let(:strategy_name) { 'foo' }
      before do
        put :update, id: locations_integration_setting.id, locations_integration_setting: {integration_setting_attributes: {strategy_name: strategy_name, vendor_endpoint: nil, override: true}}
      end

      it 'redirect' do
        response.should redirect_to(clients_integration_setting_url(locations_integration_setting.clients_integration_setting))
      end

      it 'saves update' do
        assigns(:locations_integration_setting).integration_setting.strategy_name.should eq(strategy_name)
      end
    end
  end
end