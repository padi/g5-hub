require 'rails_helper'

describe ClientSerializer do
  let(:location) { Fabricate(:location) }
  let(:client) { Fabricate(:client, locations: [location]) }
  let(:serializer) { ClientSerializer.new(client) }
  subject { indifferent_hash(serializer.to_json)[:client] }

  its([:id]) { is_expected.to eq(client.id) }
  its([:name]) { is_expected.to eq(client.name) }
  its([:urn]) { is_expected.to eq(client.urn) }
  its([:vertical]) { is_expected.to eq(client.vertical) }
  its([:street_address_1]) { is_expected.to eq(client.street_address_1) }
  its([:street_address_2]) { is_expected.to eq(client.street_address_2) }
  its([:city]) { is_expected.to eq(client.city) }
  its([:state]) { is_expected.to eq(client.state) }
  its([:postal_code]) { is_expected.to eq(client.postal_code) }
  its([:fax]) { is_expected.to eq(client.fax) }
  its([:email]) { is_expected.to eq(client.email) }
  its([:tel]) { is_expected.to eq(client.tel) }
  its([:domain_type]) { is_expected.to eq(client.domain_type) }
  its([:domain]) { is_expected.to eq(client.domain) }
  its([:locations]) { is_expected.to_not be_empty }
  its([:uid]) { is_expected.to eq("http://localhost/clients/#{client.urn}")}
end
