class RenameCustomerIdToClientIdOnLocations < ActiveRecord::Migration
  def up
    rename_column :locations, :customer_id, :client_id
  end

  def down
    rename_column :locations, :client_id, :customer_id
  end
end
