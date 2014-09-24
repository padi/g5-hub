class LeadIntegrations < ActiveRecord::Migration
  def change
    rename_column :integration_settings, :vendor_endpoint, :inventory_vendor_endpoint
    rename_column :integration_settings, :vendor_user_name, :inventory_vendor_user_name
    rename_column :integration_settings, :vendor_password, :inventory_vendor_password
    add_column :integration_settings, :inventory_service_auth_token, :string
    add_column :integration_settings, :lead_vendor_endpoint, :string
    add_column :integration_settings, :lead_vendor_user_name, :string
    add_column :integration_settings, :lead_vendor_password, :string
    add_column :integration_settings, :lead_strategy_name, :string
  end
end
