class AddUrnToLocationsIntegrationSettings < ActiveRecord::Migration
  def change
    change_table :locations_integration_settings do |t|
      t.string :urn
      t.timestamps
    end
  end
end
