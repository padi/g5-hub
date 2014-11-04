class Location < ActiveRecord::Base
  SOCIAL_NETWORKS = %w(Twitter Facebook Yelp Pinterest Foursquare Tumblr Instagram Vimeo YouTube)
  DEMOGRAPHIC_OPTIONS = ['Senior Apartments', 'Student Housing']
  PRIMARY_OFFERINGS = ['Apartments', 'Townhomes', 'Condos', 'Other']
  LANDMARK_TYPES = ['Hospital', 'Lake', 'Recreation Area', 'Military Base', 'Employer', 'University']
  PROPERTY_FEATURES = ['Luxury', 'Affordable', 'Gated', 'Furnished']
  STYLE_DESIGNS = ['High Rise', 'Modern', 'Victorian', 'Contemporary', 'Ranch', 'Garden', 'Resort']
  STYLE_COSTS = ['Luxury', 'Affordable', 'Low Income']
  RECORD_TYPE = ENV['APP_NAMESPACE'] + "-cl"
  STATUS_TYPES = ["Pending", "Live", "Suspended"]

  belongs_to :client
  has_many :locations_integration_settings, dependent: :destroy

  Paperclip.interpolates :bucket_prefix  do |attachment, style|
    "#{attachment.instance.client.urn}/#{attachment.instance.urn}"
  end

  has_attached_file :thumbnail,
                    :styles => { :thumb => "80x80>",
                                 :original => "300x300"},
                    :default_url => "/images/:style/missing.png",
                    :storage => :s3,
                    :url => ":s3_domain_url",
                    :path => ":bucket_prefix/:attachment/:style/:filename",
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials}

  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/

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
  validates :status, presence: true, inclusion: { in: STATUS_TYPES, message: "%{value} is not a valid status" }

  after_initialize :not_corporate_by_default
  after_create :set_urn

  geocoded_by :full_street_address
  after_validation :geocode, if: ->(loc){ loc.latitude.blank? or loc.longitude.blank? }

  scope :corporate, -> { where(corporate: true) }
  scope :not_corporate, -> { where(corporate: false) }

  def hashed_id
    "#{self.created_at.to_i}#{self.id}".to_i.to_s(36)
  end

  def to_param
    self.urn
  end

  def s3_credentials
    {:bucket =>            ENV['AWS_S3_BUCKET'],
     :access_key_id =>     ENV['AWS_ACCESS_KEY_ID'],
     :secret_access_key => ENV['AWS_SECRET_ACCES_KEY']}
  end

  def bucket_prefix
    "#{client.urn}/#{urn}"
  end

  def full_street_address
    [street_address_1, city, state].compact.join(', ')
  end

  private

  def set_urn
    update_attributes(urn: "#{RECORD_TYPE}-#{hashed_id}-#{name.parameterize}")
  end

  def not_corporate_by_default
    self.corporate = false if corporate.blank?
  end

end

