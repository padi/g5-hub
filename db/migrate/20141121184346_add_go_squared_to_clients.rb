class AddGoSquaredToClients < ActiveRecord::Migration
  def change
    add_column :clients, :go_squared_client_id, :string
    add_column :clients, :go_squared_tags, :string
  end
end
