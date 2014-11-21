require 'rails_helper'

describe LocationSerializer do
  let(:location) { Fabricate(:location, client: Fabricate(:client)) }
  let(:serializer) { LocationSerializer.new(location) }
  subject { indifferent_hash(serializer.to_json)[:location] }

  LocationSerializer::LOCATION_SERIALIZED_ATTRIBUTES.each do |field|
    its([field]) { is_expected.to eq(location.send(field)) }
  end

  its([:created_at]) { is_expected.to_not be_blank }
  its([:updated_at]) { is_expected.to_not be_blank }
  its([:uid]) { eq("http://#{ENV['HOST']}/clients/#{location.client.urn}/locations#{location.urn}") }
  its([:client_uid]) { eq("http://#{ENV['HOST']}/clients/#{location.client.urn}") }
end