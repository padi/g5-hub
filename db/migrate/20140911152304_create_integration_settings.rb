class CreateIntegrationSettings < ActiveRecord::Migration
  def change
    create_table :integration_settings do |t|
      t.belongs_to :location
      t.string :inventory_service_url
      t.string :etl_strategy_name
      t.string :vendor_user_name
      t.string :vendor_password
      t.string :vendor_endpoint
      t.timestamps
    end

    create_table :custom_integration_settings do |t|
      t.belongs_to :integration_setting
      t.string :name
      t.string :value
      t.timestamps
    end

    add_index :integration_settings, :location_id
    add_index :custom_integration_settings, :integration_setting_id
  end
end
