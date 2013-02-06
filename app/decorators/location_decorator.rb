class LocationDecorator < Draper::Decorator
  include HentryableDates

  delegate :name, :urn, :corporate
end
