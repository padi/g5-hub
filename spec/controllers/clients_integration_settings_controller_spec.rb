require 'rails_helper'

describe ClientsIntegrationSettingsController, auth_controller: true do
  before do
    allow(Resque).to receive(:enqueue)
  end

  describe 'GET index' do
    before { expect(ClientsIntegrationSetting).to receive(:add_job_stats) }
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
    it 'assigns job_setting' do
      subject
      expect(assigns(:clients_integration_setting).integration_setting.job_setting).to_not be_nil
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

      it 'assigns job_setting' do
        subject
        expect(assigns(:clients_integration_setting).integration_setting.job_setting).to_not be_nil
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
      let(:client) { clients_integration_setting.client }
      subject(:delete_destroy) { delete :destroy, id: clients_integration_setting.id }

      it { is_expected.to redirect_to(clients_integration_settings_url) }

      it 'is destroyed' do
        subject
        expect(ClientsIntegrationSetting.exists?(clients_integration_setting.id)).to be_falsey
      end

      it 'enques webhooks' do
        subject
        expect(Resque).to have_received(:enqueue).
                              with(WebhookPosterJob, client.id, :post_client_update_webhooks)
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
    let(:client) { Client.find(attrs[:client_id]) }

    describe 'success' do
      before do
        post :create, clients_integration_setting: attrs
      end
      it { is_expected.to redirect_to(clients_integration_setting_url(assigns(:clients_integration_setting).id)) }

      it 'enques webhooks' do
        expect(Resque).to have_received(:enqueue).
                              with(WebhookPosterJob, client.id, :post_client_update_webhooks)
      end
    end

    describe 'failure - invalid' do
      let(:attrs) { Fabricate.attributes_for(:clients_integration_setting, vendor_action: nil) }
      subject(:post_create) { post :create, clients_integration_setting: attrs }
      it { is_expected.to render_template(:new) }
    end
  end

  describe 'GET show' do
    describe 'success' do
      before do
        expect(ClientsIntegrationSetting).to receive(:find).and_return(clients_integration_setting)
        expect(clients_integration_setting).to receive(:load_current_jobs_by_location)
      end
      subject(:get_show) { get :show, id: clients_integration_setting.id }
      it { is_expected.to render_template(:show) }
      it 'decorates locations_integration_settings' do
        subject
        expect(assigns(:locations_integration_settings)).to be_decorated
      end
    end

    describe 'not found' do
      it 'raises error when clients integration setting not found' do
        expect { get :show, id: 'madeup' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PUT update' do
    describe 'success' do
      before do
        clients_integration_setting.locations_integration_settings.create(location: Fabricate(:location), integration_setting: Fabricate(:integration_setting, job_setting: Fabricate(:job_setting)))
        clients_integration_setting.integration_setting.create_job_setting(Fabricate.to_params(:job_setting))
      end

      context 'without job setting' do
        subject(:put_update) { put :update, id: clients_integration_setting.id, clients_integration_setting:
                                                {vendor_action:                  ClientsIntegrationSetting::LEAD_VENDOR_ACTION,
                                                 integration_setting_attributes: Fabricate.to_params(:integration_setting).merge(job_setting_attributes: {frequency: ''})} }
        it { is_expected.to redirect_to(clients_integration_setting_url(clients_integration_setting)) }
        it 'updates the clients_integration_setting' do
          subject
          expect(ClientsIntegrationSetting.find(clients_integration_setting.id).vendor_action).to eq(ClientsIntegrationSetting::LEAD_VENDOR_ACTION)
        end

        it 'enques webhooks' do
          subject
          expect(Resque).to have_received(:enqueue).
                                with(WebhookPosterJob, clients_integration_setting.client.id, :post_client_update_webhooks)
        end

        it 'destroys location job settings if it does not have a job setting' do
          subject
          integration_setting = ClientsIntegrationSetting.find(clients_integration_setting.id).locations_integration_settings.first.integration_setting
          expect(integration_setting.job_setting).to be_nil
        end
      end

      context 'with job setting' do
        subject(:put_update) { put :update, id: clients_integration_setting.id, clients_integration_setting: {vendor_action: ClientsIntegrationSetting::LEAD_VENDOR_ACTION} }
        it { is_expected.to redirect_to(clients_integration_setting_url(clients_integration_setting)) }
        it 'destroys location job settings if it does not have a job setting' do
          subject
          integration_setting = ClientsIntegrationSetting.find(clients_integration_setting.id).locations_integration_settings.first.integration_setting
          expect(integration_setting.job_setting).to_not be_nil
        end
      end
    end

    describe 'failure invalid' do
      subject(:put_update) { put :update, id: clients_integration_setting.id, clients_integration_setting: {vendor_action: nil} }
      it { is_expected.to render_template(:edit) }
    end
  end
end