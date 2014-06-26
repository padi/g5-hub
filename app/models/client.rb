class Client < ActiveRecord::Base
  RECORD_TYPE = "g5-c"
  VERTICALS = %w(Self-Storage Apartments Assisted-Living)
  DOMAIN_TYPES = %w(SingleDomainClient MultiDomainClient)

  has_many :locations

  validates :name, uniqueness: true, presence: true
  validates :vertical, presence: true,
                       inclusion: { in: VERTICALS, message: "%{value} is not a valid vertical" }
  validates :domain_type, presence: true,
                          inclusion: { in: DOMAIN_TYPES, message: "%{value} is not a valid domain type" }
  validates :city, presence: true
  validates :state, presence: true

  accepts_nested_attributes_for :locations,
    allow_destroy: true,
    reject_if: lambda { |attrs| attrs[:name].blank? }

  after_update :post_client_update_webhooks
  after_create :set_urn, :post_configurator_webhook

  def record_type
    RECORD_TYPE
  end

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

  def post_configurator_webhook
    WebhookPoster.new(self).post_configurator_webhook
  end

  def post_client_update_webhooks
    WebhookPoster.new(self).post_client_update_webhooks
  end
end
