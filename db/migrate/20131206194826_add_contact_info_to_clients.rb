class AddContactInfoToClients < ActiveRecord::Migration
  def change
    add_column :clients, :street_address_1, :string
    add_column :clients, :street_address_2, :string
    add_column :clients, :city, :string
    add_column :clients, :state, :string
    add_column :clients, :postal_code, :string
    add_column :clients, :fax, :string
    add_column :clients, :email, :string
  end
end
