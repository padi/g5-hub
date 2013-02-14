require 'spec_helper'

class HentryableDatesTester
  include HentryableDates
end

<<<<<<< HEAD:spec/lib/hentryable_dates_spec.rb
describe HentryableDates do
  let(:tester) { HentryableDatesTester.new }
  before { tester.stub_chain(:model, :created_at).and_return(Time.now) }
=======
describe Hentryable do
  subject(:tester) { HentryableTester.new }
  let(:model) { double(created_at: Time.now, id: 319, name: "Test Object") }
  before { tester.stub(model: model) }

  its(:urn) { should eq("g5-test-319-test-object") }
  its(:to_param) { should eq("g5-test-319-test-object") }
>>>>>>> 7923bc0... Fix bad links in hentry.:spec/lib/hentryable_spec.rb

  describe "#created_at_computer_readable" do
    it "is computer readable" do
      regex = /#{Time::DATE_FORMATS[:computer].gsub(/%./, "\\d+")}/
      tester.created_at_computer_readable.should match regex
    end
  end

  describe "#created_at_human_readable" do
    it "is human readable" do
      regex = /#{Time::DATE_FORMATS[:human].gsub(/%./, ".+")}/
      tester.created_at_human_readable.should match regex
    end
  end
end
