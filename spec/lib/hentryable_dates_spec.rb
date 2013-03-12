require 'spec_helper'

class HentryableDatesTester
  include HentryableDates
end

describe HentryableDates do
  let(:tester) { HentryableDatesTester.new }
  before { tester.stub_chain(:model, :created_at).and_return(Time.now) }

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
