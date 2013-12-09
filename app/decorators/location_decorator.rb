class LocationDecorator < Draper::Decorator
  include HentryableDates

  delegate :name, :street_address_1, :street_address_2, :city, :state, :postal_code, :fax, :email, :urn, :corporate, :hours
end
