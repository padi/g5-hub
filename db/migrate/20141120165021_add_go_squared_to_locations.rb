class AddGoSquaredToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :go_squared_client_id, :string
    add_column :locations, :go_squared_site_token, :text
  end
end
