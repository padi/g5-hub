Fabricator(:client) do
  name { Faker::Name.name }
  vertical { Client::VERTICALS.sample }
end