class AddSelfStorageInfo < ActiveRecord::Migration
  def change
    add_column :locations, :neighborhood, :string
    add_column :locations, :boat_storage, :boolean, default: false
    add_column :locations, :business_storage, :boolean, default: false
    add_column :locations, :other_storage, :boolean, default: false
    add_column :locations, :gate_access, :boolean, default: false
    add_column :locations, :security_monitoring, :boolean, default: false
    add_column :locations, :business_center, :boolean, default: false
    add_column :locations, :climate_controlled, :boolean, default: false
    add_column :locations, :heated_cooled, :boolean, default: false
    add_column :locations, :friendly_staff, :boolean, default: false
    add_column :locations, :covered_drivethru, :boolean, default: false
    add_column :locations, :covered_loading, :boolean, default: false
    add_column :locations, :rv_boat_storage, :boolean, default: false
    add_column :locations, :outside_parking, :boolean, default: false
    add_column :locations, :deliveries, :boolean, default: false
    add_column :locations, :dollies_carts, :boolean, default: false
    add_column :locations, :digital_surveillance, :boolean, default: false
    add_column :locations, :drive_up_access, :boolean, default: false
    add_column :locations, :electronic_gate, :boolean, default: false
    add_column :locations, :uhaul_trucks, :boolean, default: false
    add_column :locations, :budget_trucks, :boolean, default: false
    add_column :locations, :moving_trucks, :boolean, default: false
    add_column :locations, :free_truck, :boolean, default: false
    add_column :locations, :fenced_lighted, :boolean, default: false
    add_column :locations, :ground_level_units, :boolean, default: false
    add_column :locations, :high_ceilings, :boolean, default: false
    add_column :locations, :individual_alarmed_units, :boolean, default: false
    add_column :locations, :mail_boxes, :boolean, default: false
    add_column :locations, :major_credit_cards, :boolean, default: false
    add_column :locations, :military_discounts, :boolean, default: false
    add_column :locations, :student_discount, :boolean, default: false
    add_column :locations, :senior_discount, :boolean, default: false
    add_column :locations, :month_to_month, :boolean, default: false
    add_column :locations, :no_admin_fee, :boolean, default: false
    add_column :locations, :no_deposits, :boolean, default: false
    add_column :locations, :no_late_fees, :boolean, default: false
    add_column :locations, :online_bill_pay, :boolean, default: false
    add_column :locations, :packing_moving_supplies, :boolean, default: false
    add_column :locations, :boxes_locks, :boolean, default: false
    add_column :locations, :tenant_insurance, :boolean, default: false
    add_column :locations, :truck_rentals, :boolean, default: false
    add_column :locations, :wide_driveways, :boolean, default: false
    add_column :locations, :wine_storage, :boolean, default: false
    add_column :locations, :other_features, :string
  end
end
