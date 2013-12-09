class Location < ActiveRecord::Base
  attr_accessible :client_id, :name, :street_address_1, :street_address_2, :city, :state, :postal_code, :fax, :email, :corporate, :urn

  belongs_to :client
  validates :name, presence: true
  after_initialize :not_corporate_by_default
  after_create :set_urn

  scope :corporate, where(corporate: true)
  scope :not_corporate, where(corporate: false)

  def record_type
    "g5-cl"
  end

  def hashed_id
    "#{self.created_at.to_i}#{self.id}".to_i.to_s(36)
  end
  
  def to_param
    self.urn
  end

  private

  def set_urn
    update_attributes(urn: "#{record_type}-#{hashed_id}-#{name.parameterize}")
  end

  def not_corporate_by_default
    self.corporate = false if corporate.blank?
  end
end
