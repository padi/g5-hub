class AddContactInfoToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :street_address_1, :string
    add_column :locations, :street_address_2, :string
    add_column :locations, :city, :string
    add_column :locations, :state, :string
    add_column :locations, :postal_code, :string
    add_column :locations, :fax, :string
    add_column :locations, :email, :string
  end
end
