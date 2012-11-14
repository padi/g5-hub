class DropAdmins < ActiveRecord::Migration
  def up
    drop_table :admins
  end

  def down
    create_table :admins do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.timestamps
    end
  end
end
