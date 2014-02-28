Fabricator(:location) do
  name { Faker::Name.name }
  domain { Faker::Internet.domain_name }
  street_address_1 { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state }
  postal_code { Faker::Address.zip_code }
  phone_number { Faker::PhoneNumber.phone_number }
end
