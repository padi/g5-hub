class CreateVendor < ActiveRecord::Migration
  def change
    create_table :clients_integration_settings do |t|
      t.belongs_to :vendor
      t.string :vendor_action #[inventory, lead]
      t.belongs_to :client
      t.belongs_to :integration_setting
    end

    # override client values or add new custom settings
    create_table :locations_integration_settings do |t|
      t.belongs_to :clients_integration_setting
      t.belongs_to :location
      t.belongs_to :integration_setting
    end

    change_table :integration_settings do |t|
      [:location_id, :inventory_service_url, :inventory_service_auth_token, :lead_vendor_endpoint, :lead_vendor_user_name, :lead_vendor_password, :lead_strategy_name].each do |col_name|
        t.remove col_name
      end
      t.rename :etl_strategy_name, :strategy_name
      t.rename :inventory_vendor_user_name, :vendor_user_name
      t.rename :inventory_vendor_password, :vendor_password
      t.rename :inventory_vendor_endpoint, :vendor_endpoint
    end

    create_table :vendors do |t|
      t.string :name
    end

    add_index 'clients_integration_settings', ['client_id'], name: 'index_cis_on_client'
    add_index 'clients_integration_settings', ['vendor_id', 'client_id', 'vendor_action'], name: 'index_cis_on_vendor_and_client_and_action'
    add_index 'locations_integration_settings', ['location_id', 'clients_integration_setting_id'], name: 'index_lis_on_location_and_client_int', unique: true
    add_index 'locations_integration_settings', ['location_id'], name: 'index_lis_on_location'
  end
end
