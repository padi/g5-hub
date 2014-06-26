class Client < ActiveRecord::Base
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

  after_save :post_configurator_webhook, :post_cms_webhook
  after_create :set_urn

  def record_type
    "g5-c"
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

  def post_configurator_webhook
    url = ENV["G5_CONFIGURATOR_WEBHOOK_URL"]
    if url
      begin
        Webhook.post(url)
      rescue RuntimeError, ArgumentError => e
        logger.error e
      end
    end
  end

  def post_cms_webhook
    return if id_changed? #do nothing if this is a new record
    url = "#{client_cms_domain}#{ENV["CMS_UPDATE_PATH"]}"

    begin
      Webhook.post(url)
    rescue RuntimeError, ArgumentError => e
      logger.error e
    end
  end

  def client_cms_domain
    "https://#{urn.gsub(record_type, 'g5-cms')}.herokuapp.com"
  end
end
