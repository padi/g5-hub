class Location < ActiveRecord::Base
  attr_accessible :client_id, :name, :corporate

  belongs_to :client

  after_initialize :not_corporate_by_default

  scope :corporate, where(corporate: true)
  scope :not_corporate, where(corporate: false)

  # TODO: use draper

  def created_at_computer_readable
    created_at.utc.to_s(:computer)
  end

  def created_at_human_readable
    created_at.to_s(:human)
  end

  private

  def not_corporate_by_default
    self.corporate = false if corporate.blank?
  end
end
