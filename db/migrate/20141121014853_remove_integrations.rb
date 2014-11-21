class RemoveIntegrations < ActiveRecord::Migration
  def change
    [:locations_integration_settings,
     :vendors, :job_settings,
     :integration_settings,
     :frequency_units,
     :custom_integration_settings,
     :clients_integration_settings].each do |table_name|
      drop_table table_name
    end
  end
end
