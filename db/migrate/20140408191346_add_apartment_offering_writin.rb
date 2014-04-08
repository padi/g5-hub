class AddApartmentOfferingWritin < ActiveRecord::Migration
  def change
    add_column :locations, :primary_offering_other, :string
  end
end
