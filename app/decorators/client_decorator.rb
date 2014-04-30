class ClientDecorator < Draper::Decorator
  include HentryableDates

  delegate :name, :street_address_1, :street_address_2, :city, :state,
           :postal_code, :fax, :email, :vertical, :urn, :domain_type
  decorates_association :locations, with: LocationDecorator

  def record_type
    "g5-c"
  end
end
