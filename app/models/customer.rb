class Customer < ActiveRecord::Base
  attr_accessible :admin_id, :name, :locations_attributes, :feature_ids

  belongs_to :admin
  has_many :locations
  has_and_belongs_to_many :features

  accepts_nested_attributes_for :locations, 
    allow_destroy: true, 
    reject_if: lambda { |attrs| attrs[:name].blank? }

  after_save :post_webhook

  # TODO: use draper
  
  def created_at_computer_readable
    created_at.utc.to_s(:computer)
  end

  def created_at_human_readable
    created_at.to_s(:human)
  end

  private

  def post_webhook
    url = ENV["CONFIGURATOR_WEBHOOK_URL"]
    if url
      Webhook.post(url) 
    end
  end
end
