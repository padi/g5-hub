class ChangeOtherStorageType < ActiveRecord::Migration
  def change
    remove_column :locations, :other_storage
    add_column :locations, :other_storage, :string
  end
end
