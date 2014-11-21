class RemoveGoSquaredFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :go_squared_client_id, :string
  end
end
