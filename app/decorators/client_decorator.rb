class ClientDecorator < Draper::Decorator
  include HentryableDates

  delegate :name, :street_address_1, :street_address_2, :city, :state,
           :postal_code, :fax, :email, :vertical, :urn, :domain_type, :domain
  decorates_association :locations, with: LocationDecorator
end

