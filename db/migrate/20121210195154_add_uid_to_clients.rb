class AddUidToClients < ActiveRecord::Migration
  def change
    add_column :clients, :urn, :string
    add_column :locations, :urn, :string
  end
end
