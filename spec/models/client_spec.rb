require 'spec_helper'

describe Client do
  let(:client) { Fabricate(:client, id: 123) }
  
  it { client.should be_valid }
  
  describe "Identifiers" do
    before do
      Time.any_instance.stub(:to_i) { 1325404800 }
    end
    
    it { client.hashed_id.should eq "gwvrsozf" }
    it { client.record_type.should eq "g5-c"}
    it { client.urn.should eq "g5-c-gwvrsozf-#{client.name.parameterize}"}
    it { client.to_param.should eq client.urn }
  end
end