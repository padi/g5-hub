class Location < ActiveRecord::Base
  SOCIAL_NETWORKS = %w(Twitter Facebook Yelp Pinterest Foursquare Tumblr Instagram Vimeo YouTube)
  DEMOGRAPHIC_OPTIONS = ['Senior Apartments', 'Student Housing']
  PRIMARY_OFFERINGS = ['Apartments', 'Townhomes', 'Condos', 'Other']
  LANDMARK_TYPES = ['Hospital', 'Lake', 'Recreation Area', 'Military Base', 'Employer', 'University']
  PROPERTY_FEATURES = ['Luxury', 'Affordable', 'Gated', 'Furnished']
  STYLE_DESIGNS = ['High Rise', 'Modern', 'Victorian', 'Contemporary', 'Ranch', 'Garden', 'Resort']
  STYLE_COSTS = ['Luxury', 'Affordable', 'Low Income']
  RECORD_TYPE = ENV['APP_NAMESPACE'] + "-cl"

  belongs_to :client

  validates :name, presence: true
  validates :domain, presence: true
  validates :street_address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone_number, presence: true
  validates :specific_demographic, inclusion: { in: DEMOGRAPHIC_OPTIONS, message: "%{value} is not a valid demographic" }, if: :specific_demographic?
  validates :primary_offering, inclusion: { in: PRIMARY_OFFERINGS, message: "%{value} is not a valid offering" }, if: :primary_offering?
  validates :landmark_1_type, inclusion: { in: LANDMARK_TYPES, message: "%{value} is not a valid landmark" }, if: :landmark_1_type?
  validates :landmark_2_type, inclusion: { in: LANDMARK_TYPES, message: "%{value} is not a valid landmark" }, if: :landmark_2_type?
  validates :property_feature_1, inclusion: { in: PROPERTY_FEATURES, message: "%{value} is not a valid property feature" }, if: :property_feature_1?
  validates :property_feature_2, inclusion: { in: PROPERTY_FEATURES, message: "%{value} is not a valid property feature" }, if: :property_feature_2?
  validates :property_feature_3, inclusion: { in: PROPERTY_FEATURES, message: "%{value} is not a valid property feature" }, if: :property_feature_3?
  validates :style_design, inclusion: { in: STYLE_DESIGNS, message: "%{value} is not a valid style design" }, if: :style_design?
  validates :style_cost, inclusion: { in: STYLE_COSTS, message: "%{value} is not a valid style_cost" }, if: :style_cost?

  after_initialize :not_corporate_by_default
  after_create :set_urn

  scope :corporate, -> { where(corporate: true) }
  scope :not_corporate, -> { where(corporate: false) }

  def hashed_id
    "#{self.created_at.to_i}#{self.id}".to_i.to_s(36)
  end

  def to_param
    self.urn
  end

  private

  def set_urn
    update_attributes(urn: "#{RECORD_TYPE}-#{hashed_id}-#{name.parameterize}")
  end

  def not_corporate_by_default
    self.corporate = false if corporate.blank?
  end
end
