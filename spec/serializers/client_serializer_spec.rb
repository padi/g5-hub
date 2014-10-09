require 'spec_helper'

describe ClientSerializer do
  let(:location) { Fabricate(:location) }
  let(:client) { Fabricate(:client, locations: [location]) }
  let(:serializer) { ClientSerializer.new(client) }
  subject { indifferent_hash(serializer.to_json)[:client] }

  its([:id]) { should eq(client.id) }
  its([:name]) { should eq(client.name) }
  its([:urn]) { should eq(client.urn) }
  its([:vertical]) { should eq(client.vertical) }
  its([:street_address_1]) { should eq(client.street_address_1) }
  its([:street_address_2]) { should eq(client.street_address_2) }
  its([:city]) { should eq(client.city) }
  its([:state]) { should eq(client.state) }
  its([:postal_code]) { should eq(client.postal_code) }
  its([:fax]) { should eq(client.fax) }
  its([:email]) { should eq(client.email) }
  its([:tel]) { should eq(client.tel) }
  its([:domain_type]) { should eq(client.domain_type) }
  its([:domain]) { should eq(client.domain) }
  its([:locations]) { should_not be_empty }
  its([:uid]) { should eq("http://#{ENV['HOST']}/clients/#{client.urn}")}
end