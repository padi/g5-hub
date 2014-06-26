class ClientDecorator < Draper::Decorator
  include HentryableDates

  delegate_all  
  decorates_association :locations, with: LocationDecorator

end

