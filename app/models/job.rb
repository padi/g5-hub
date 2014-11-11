class Job
  include Virtus.model

  attribute :uid, String
  attribute :urn, String
  attribute :state, String
  attribute :created_at, DateTime
  attribute :updated_at, DateTime
  attribute :integration_setting_uid, String
  attribute :message, String
end