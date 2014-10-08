Fabricator(:client) do
  name { Faker::Name.name }
  vertical { Client::VERTICALS.sample }
  city { "Los Angeles" }
  state { "CA" }
  domain_type { Client::DOMAIN_TYPES.sample }
  domain { Faker::Internet.url }
  inventory_service_uri 'http://localhost:5777/api/v1/storage_facilities'
end
