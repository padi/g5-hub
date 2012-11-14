class Feature < ActiveRecord::Base
  attr_accessible :name
  
  has_and_belongs_to_many :customers
 
  # TODO: use draper
  
  def created_at_computer_readable
    # http://www.w3schools.com/html5/att_time_datetime.asp
    created_at.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
  end

  def created_at_human_readable
    created_at.strftime("%I:%M%P on %B %e, %Y")
  end
end
