class ClientDecorator < Draper::Decorator
  include HentryableDates

  delegate :name, :urn
  decorates_association :locations
end
