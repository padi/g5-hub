require 'rails_helper'

describe ClientsIntegrationSettingsController, auth_controller: true do
  describe 'GET index' do
    subject(:get_index) { get :index }
    its(:status) { is_expected.to eq(200) }
    it { is_expected.to render_template(:index) }
    it 'assigns client_integration_settings' do
      subject
      expect(assigns(:clients_integration_settings)).to be_decorated
    end
  end

  describe 'GET new' do
    subject(:get_new) { get :new }
    its(:status) { is_expected.to eq(200) }
    it { is_expected.to render_template(:new) }
    it 'assigns client_integration_setting' do
      subject
      expect(assigns(:clients_integration_setting)).to_not be_nil
    end
  end

  let(:clients_integration_setting) { Fabricate(:clients_integration_setting) }

  describe 'GET edit' do
    describe 'success' do
      subject(:get_edit) { get :edit, id: clients_integration_setting.id }
      its(:status) { is_expected.to eq(200) }
      it { is_expected.to render_template(:edit) }
      it 'assigns client_integration_setting' do
        subject
        expect(assigns(:clients_integration_setting)).to eq(clients_integration_setting)
      end
    end

    describe 'failure' do
      it 'raises recordnotfound with invalid id' do
        expect { get :edit, id: 'madeup' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE destroy' do
    describe 'success' do
      subject(:delete_destroy) { delete :destroy, id: clients_integration_setting.id }
      it { is_expected.to redirect_to(clients_integration_settings_url) }
      it 'is destroyed' do
        subject
        expect(ClientsIntegrationSetting.exists?(clients_integration_setting.id)).to be_falsey
      end
    end

    describe 'failure' do
      it 'raises recordnotfound with invalid id' do
        expect { delete :destroy, id: 'madeup' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST create' do
    let(:attrs) { Fabricate.attributes_for(:clients_integration_setting) }
    describe 'success' do
      before do
        post :create, clients_integration_setting: attrs
      end
      it { is_expected.to redirect_to(clients_integration_setting_url(assigns(:clients_integration_setting).id)) }
    end

    describe 'failure - invalid' do
      let(:attrs) { Fabricate.attributes_for(:clients_integration_setting, vendor_action: nil) }
      subject(:post_create) { post :create, clients_integration_setting: attrs }
      it { is_expected.to render_template(:new) }
    end
  end

  describe 'GET show' do
    describe 'success' do
      subject(:get_show) { get :show, id: clients_integration_setting.id }
      it { is_expected.to render_template(:show) }
    end

    describe 'not found' do
      it 'raises error when clients integration setting not found' do
        expect { get :show, id: 'madeup' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PUT update' do
    describe 'success' do
      subject(:put_update) { put :update, id: clients_integration_setting.id, clients_integration_setting: {vendor_action: ClientsIntegrationSetting::LEAD_VENDOR_ACTION} }
      it { is_expected.to redirect_to(clients_integration_setting_url(clients_integration_setting)) }
      it 'updates the clients_integration_setting' do
        subject
        expect(ClientsIntegrationSetting.find(clients_integration_setting.id).vendor_action).to eq(ClientsIntegrationSetting::LEAD_VENDOR_ACTION)
      end
    end

    describe 'failure invalid' do
      subject(:put_update) { put :update, id: clients_integration_setting.id, clients_integration_setting: {vendor_action: nil} }
      it { is_expected.to render_template(:edit) }
    end
  end
end