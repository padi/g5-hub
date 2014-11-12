class JobStartsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_settings

  def create
    @locations_integration_settings.each do |locations_integration_setting|
      Jobs::JobStarter.new(locations_integration_setting: locations_integration_setting).perform
    end

    flash.notice = "Job(s) started for #{@locations_integration_settings.collect { |lis| lis.location.name }.join(', ')}"

    redirect_to clients_integration_setting_path(@clients_integration_setting.id)
  end

  private
  def load_settings
    if params[:clients_integration_setting_id]
      @clients_integration_setting = ClientsIntegrationSetting.find(params[:clients_integration_setting_id])
      @locations_integration_settings = @clients_integration_setting.locations_integration_settings
    else
      locations_integration_setting = LocationsIntegrationSetting.find(params[:locations_integration_setting_id])
      @clients_integration_setting = locations_integration_setting.clients_integration_setting
      @locations_integration_settings = [locations_integration_setting]
    end
  end
end