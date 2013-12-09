class AddHoursToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :hours, :string
  end
end
