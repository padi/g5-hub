class ChangeLandmarkFields < ActiveRecord::Migration
  def change
    remove_column :locations, :hospital_landmark
    remove_column :locations, :lake_landmark
    remove_column :locations, :recreation_landmark
    remove_column :locations, :military_landmark
    remove_column :locations, :employer_landmark
    remove_column :locations, :university_landmark
    add_column :locations, :landmark_1_type, :string
    add_column :locations, :landmark_1_name, :string
    add_column :locations, :landmark_2_type, :string
    add_column :locations, :landmark_2_name, :string
  end
end
