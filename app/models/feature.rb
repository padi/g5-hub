class Feature < ActiveRecord::Base
  attr_accessible :name
  
  has_and_belongs_to_many :clients
 
  # TODO: use draper
  
  def created_at_computer_readable
    created_at.utc.to_s(:computer)
  end

  def created_at_human_readable
    created_at.to_s(:human)
  end
end
