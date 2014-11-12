require 'rails_helper'

describe JobStartsController, auth_controller: true do
  let(:clients_integration_setting) { Fabricate(:clients_integration_setting).tap { |cis| cis.integration_setting.create_job_setting(Fabricate.to_params(:job_setting)) } }
  let!(:locations_integration_setting) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }

  describe 'POST create' do
    context 'by locations_integration_setting_id' do
      describe 'success' do
        before do
          expect(G5::Jobbing::JobStarter).to receive(:new).and_return(double(:perform, perform: true))
          post :create, locations_integration_setting_id: locations_integration_setting.id
        end

        specify { expect(response).to redirect_to(clients_integration_setting_url(locations_integration_setting.clients_integration_setting.id)) }
        specify { expect(controller.notice).to eq("Job(s) started for #{locations_integration_setting.location.name}") }
      end

      describe 'failure' do
        describe 'unknown locations_integration_setting_id' do
          specify { expect { post :create, locations_integration_setting_id: 'madeup' }.to raise_error(ActiveRecord::RecordNotFound) }
        end
      end
    end

    context 'by clients_integration_setting_id' do
      let!(:locations_integration_setting_2) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }
      describe 'success' do
        before do
          allow(G5::Jobbing::JobStarter).to receive(:new).and_return(double(:perform, perform: true))
          post :create, clients_integration_setting_id: clients_integration_setting.id
        end

        specify { expect(response).to redirect_to(clients_integration_setting_url(locations_integration_setting.clients_integration_setting.id)) }
        specify { expect(controller.notice).to eq("Job(s) started for #{clients_integration_setting.locations_integration_settings.collect { |lis| lis.location.name }.join(', ')}") }
      end

      describe 'failure' do
        describe 'unknown locations_integration_setting_id' do
          specify { expect { post :create, clients_integration_setting_id: 'madeup' }.to raise_error(ActiveRecord::RecordNotFound) }
        end
      end
    end
  end
end