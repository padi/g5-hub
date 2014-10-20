class AddAttachmentThumbnailToLocations < ActiveRecord::Migration
  def self.up
    change_table :locations do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :locations, :thumbnail
  end
end
