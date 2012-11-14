class Location < ActiveRecord::Base
  attr_accessible :customer_id, :name, :corporate

  belongs_to :customer

  after_initialize :not_corporate_by_default

  scope :corporate, where(corporate: true)
  scope :not_corporate, where(corporate: false)

  # TODO: use draper

  def created_at_computer_readable
    # http://www.w3schools.com/html5/att_time_datetime.asp
    created_at.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
  end

  def created_at_human_readable
    created_at.strftime("%I:%M%P on %B %e, %Y")
  end

  private

  def not_corporate_by_default
    self.corporate = false if corporate.blank?
  end
end
