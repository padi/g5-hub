class ClientSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :uid, :name, :urn, :vertical, :street_address_1, :street_address_2,
             :city, :state, :postal_code, :fax, :email, :tel, :domain_type, :domain,
             :created_at, :updated_at
  has_many :locations

  def uid
    client_url(id: object.id, host: "#{ENV['HEROKU_APP_NAME'].herokuapp.com")
  end
end
