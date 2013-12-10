Fabricator(:client) do
  name { Faker::Name.name }
  vertical { Client::VERTICALS.sample }
  city { "Los Angeles" }
  state { "CA" }
end