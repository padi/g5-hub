class CreateJobsSettings < ActiveRecord::Migration
  def change
    create_table :job_settings do |t|
      t.belongs_to :integration_setting
      t.integer :frequency_unit_id
      t.integer :frequency
      t.timestamps
    end

    create_table :frequency_units do |t|
      t.string :name
      t.integer :minutes_multiplier
      t.timestamps
    end

    add_index :job_settings, :integration_setting_id
  end
end
