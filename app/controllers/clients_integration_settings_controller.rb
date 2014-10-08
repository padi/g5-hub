class ClientsIntegrationSettingsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  before_filter :load_clients_integration_setting, only: [:show, :edit, :update, :destroy]

  def index
    @clients_integration_settings = ClientsIntegrationSetting.includes(:client).order('clients.name').decorate
  end

  def new
    @clients_integration_setting = ClientsIntegrationSetting.new
    @clients_integration_setting.build_integration_setting
    @clients_integration_setting.integration_setting.custom_integration_settings.build
  end

  def edit

  end

  def show

  end

  def create
    @clients_integration_setting = ClientsIntegrationSetting.create(clients_integration_setting_params)
    respond_with @clients_integration_setting, notice: 'Successfully created Integration!'
  end

  def update
    @clients_integration_setting.update_attributes(clients_integration_setting_params)
    respond_with @clients_integration_setting, notice: 'Successfully updated Integration!'
  end

  def destroy
    @clients_integration_setting.destroy
    respond_with @clients_integration_setting
  end

  private
  def load_clients_integration_setting
    @clients_integration_setting = ClientsIntegrationSetting.find(params[:id]).decorate
  end

  def clients_integration_setting_params
    params.require(:clients_integration_setting).permit(:client_id, :id, :vendor_id, :vendor, :vendor_action, location_ids: [],
                                                        integration_setting_attributes: [:strategy_name, :vendor_user_name, :vendor_password, :vendor_endpoint, :id, :_destroy, custom_integration_settings_attributes: [:name, :value, :id, :_destroy]])
  end
end

