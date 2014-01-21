class AddDomainToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :domain, :string
  end
end
