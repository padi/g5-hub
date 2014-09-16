class IntegrationSettingsController < ApplicationController
  before_filter :load_location
  respond_to :html

  def new
    @integration_setting = @location.build_integration_setting
    @integration_setting.custom_integration_settings.build
  end

  def create
    @integration_setting = @location.build_integration_setting(integration_setting_params)
    if @integration_setting.save
      flash[:notice] = "Successfully created integration setting"
    end
    respond_with @integration_setting, location: client_url(@location.client)
  end

  def edit
    @integration_setting = @location.integration_setting
  end

  def update
    @integration_setting = @location.integration_setting

    if @integration_setting.update_attributes(integration_setting_params)
      flash[:notice] = "Successfully updated integration setting"
    end
    respond_with @integration_setting, location: client_url(@location.client)
  end

  private
  def load_location
    @location = Location.find_by_urn(params[:location_id]) || Location.find(params[:location_id])
  end

  def integration_setting_params
    params.require(:integration_setting).permit(:etl_strategy_name, :inventory_service_url, :vendor_user_name, :vendor_password, :vendor_endpoint, custom_integration_settings_attributes: [:id, :name, :_destroy, :value])
  end
end