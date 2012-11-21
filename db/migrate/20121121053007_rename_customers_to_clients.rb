class RenameCustomersToClients < ActiveRecord::Migration
  def up
    rename_table :customers, :clients
  end

  def down
    rename_table :clients, :customers
  end
end
