class ClientSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :name, :urn, :vertical, :street_address_1, :street_address_2,
             :city, :state, :postal_code, :fax, :email, :tel, :domain_type, :domain,
             :created_at, :updated_at
  has_many :locations
end