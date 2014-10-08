class LocationsIntegrationSettingsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  before_filter :load_locations_integration_setting, only: [:show, :edit, :update, :destroy]

  def update
    @locations_integration_setting.update_attributes locations_integration_setting_params

    respond_with @locations_integration_setting, location: clients_integration_setting_url(@locations_integration_setting.clients_integration_setting.id)
  end

  def edit
    @locations_integration_setting.build_integration_setting unless @locations_integration_setting.integration_setting
    @locations_integration_setting.integration_setting.custom_integration_settings.build if @locations_integration_setting.integration_setting.custom_integration_settings.empty?
  end

  private
  def load_locations_integration_setting
    @locations_integration_setting = LocationsIntegrationSetting.find(params[:id])
  end

  def locations_integration_setting_params
    params.require(:locations_integration_setting).permit(integration_setting_attributes: [:override, :strategy_name, :vendor_user_name, :vendor_password, :vendor_endpoint, :id, :_destroy, custom_integration_settings_attributes: [:name, :value, :id, :_destroy]])
  end
end