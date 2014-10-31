class ClientsIntegrationSettingsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  before_filter :load_clients_integration_setting, only: [:show, :edit, :update, :destroy]

  def index
    @clients_integration_settings = ClientsIntegrationSetting.includes(:client).order('clients.name').decorate
  end

  def new
    @clients_integration_setting = ClientsIntegrationSetting.new
    build_required
  end

  def edit
    build_required
  end

  def show

  end

  def create
    @clients_integration_setting = ClientsIntegrationSetting.new(clients_integration_setting_params)
    build_required unless @clients_integration_setting.save
    respond_with @clients_integration_setting, notice: 'Successfully created Integration!'
  end

  def update
    destroy_location_job_settings_if_needed if @clients_integration_setting.update_attributes(clients_integration_setting_params)

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
    params.require(:clients_integration_setting).permit(:client_id, :id, :vendor_id, :vendor, :vendor_action,
                                                        location_ids:                   [],
                                                        integration_setting_attributes: [:strategy_name, :vendor_user_name, :vendor_password, :vendor_endpoint, :id, :_destroy, job_setting_attributes: [:frequency_unit_id, :frequency, :id, :_destroy], custom_integration_settings_attributes: [:name, :value, :id, :_destroy]])
  end

  def destroy_location_job_settings_if_needed
    @clients_integration_setting.integration_setting.reload
    @clients_integration_setting.locations_integration_settings.each { |lis| lis.integration_setting.try(:job_setting).try(:destroy) } if @clients_integration_setting.integration_setting.job_setting.nil?
  end

  def build_required
    @clients_integration_setting.build_integration_setting unless @clients_integration_setting.integration_setting
    @clients_integration_setting.integration_setting.custom_integration_settings.build if @clients_integration_setting.integration_setting.custom_integration_settings.empty?
    @clients_integration_setting.integration_setting.build_job_setting unless @clients_integration_setting.integration_setting.job_setting
  end
end

