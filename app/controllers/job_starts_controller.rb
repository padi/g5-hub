class JobStartsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_locations_integration_setting

  def create
    Jobs::JobStarter.new(locations_integration_setting: @locations_integration_setting).perform
    flash.notice = "Job started for #{@locations_integration_setting.location.name}"

    redirect_to clients_integration_setting_path(@locations_integration_setting.clients_integration_setting.id)
  end

  private
  def load_locations_integration_setting
    @locations_integration_setting ||= LocationsIntegrationSetting.find(params[:locations_integration_setting_id])
  end
end