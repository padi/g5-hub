class ChangeQualifierFields < ActiveRecord::Migration
  def change
    remove_column :locations, :luxury_property
    remove_column :locations, :affordable_property
    remove_column :locations, :gated_property
    remove_column :locations, :gated_property
    add_column :locations, :property_feature_1, :string
    add_column :locations, :property_feature_2, :string
    add_column :locations, :property_feature_3, :string
  end
end
