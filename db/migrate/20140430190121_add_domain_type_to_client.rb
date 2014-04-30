class AddDomainTypeToClient < ActiveRecord::Migration
  def change
    add_column :clients, :domain_type, :string
  end
end
