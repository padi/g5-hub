class RenameCustomersFeaturesToClientsFeatures < ActiveRecord::Migration
  def up
    rename_table :customers_features, :clients_features
    rename_column :clients_features, :customer_id, :client_id
  end

  def down
    rename_column :clients_features, :client_id, :customer_id
    rename_table :clients_features, :customers_features
  end
end
