class ClientDecorator < Draper::Decorator
  include HentryableDates

  delegate :name, :vertical, :urn
  decorates_association :locations, with: LocationDecorator

  def record_type
    "g5-c"
  end
end
