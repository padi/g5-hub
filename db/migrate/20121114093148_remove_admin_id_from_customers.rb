class RemoveAdminIdFromCustomers < ActiveRecord::Migration
  def up
    remove_column :customers, :admin_id
  end

  def down
    add_column :customers, :admin_id, :integer
  end
end
