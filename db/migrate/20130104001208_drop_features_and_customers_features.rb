class DropFeaturesAndCustomersFeatures < ActiveRecord::Migration
  def up
    drop_table :features
    drop_table :clients_features
  end

  def down
    create_table :features do |t|
      t.string :name
      t.timestamps
    end
    create_table :clients_features, id: false do |t|
      t.integer :client_id
      t.integer :feature_id
    end
  end
end
