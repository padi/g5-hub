class LocationDecorator < Draper::Decorator
  include HentryableDates

  delegate_all
end

