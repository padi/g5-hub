class AddMissingSelfStorageFields < ActiveRecord::Migration
  def change
    add_column :locations, :rv_storage, :boolean, default: false
    add_column :locations, :seven_day_access, :boolean, default: false
  end
end
