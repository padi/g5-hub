class AddVerticalToClients < ActiveRecord::Migration
  def change
    add_column :clients, :vertical, :string
  end
end
