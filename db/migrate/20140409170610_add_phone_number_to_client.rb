class AddPhoneNumberToClient < ActiveRecord::Migration
  def change
    add_column :clients, :tel, :string
  end
end
