require 'rails_helper'

describe JobStartsController, auth_controller: true do
  let(:clients_integration_setting) { Fabricate(:clients_integration_setting).tap { |cis| cis.integration_setting.create_job_setting(Fabricate.to_params(:job_setting)) } }
  let(:locations_integration_setting) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }

  describe 'POST create' do
    describe 'success' do
      before do
        expect(Jobs::JobStarter).to receive(:new).and_return(double(:perform, perform: true))
        post :create, locations_integration_setting_id: locations_integration_setting.id
      end

      specify { expect(response).to redirect_to(clients_integration_setting_url(locations_integration_setting.clients_integration_setting.id)) }
      specify { expect(controller.notice).to eq("Job started for #{locations_integration_setting.location.name}") }
    end

    describe 'failure' do
      describe 'unknown locations_integration_setting_id' do
        specify { expect { post :create, locations_integration_setting_id: 'madeup' }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end
  end
end