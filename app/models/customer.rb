class Customer < ActiveRecord::Base
  attr_accessible :admin_id, :name, :locations_attributes, :feature_ids

  belongs_to :admin
  has_many :locations
  has_and_belongs_to_many :features

  accepts_nested_attributes_for :locations, 
    allow_destroy: true, 
    reject_if: lambda { |attrs| attrs[:name].blank? }

  # TODO: use draper
  
  def created_at_computer_readable
    # http://www.w3schools.com/html5/att_time_datetime.asp
    created_at.strftime("%Y-%m-%dT%H:%M:%S%Z")
  end

  def created_at_human_readable
    created_at.strftime("%I:%M%P on %B %e, %Y")
  end
end