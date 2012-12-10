class AddUidToClients < ActiveRecord::Migration
  def change
    add_column :clients, :uid, :string
  end
end
