require "spec_helper"

describe Feature do
  describe "#created_at_computer_readable" do
    it "is computer readable" do
      regex = /#{Time::DATE_FORMATS[:computer].gsub(/%./, "\\d+")}/
      location.created_at_computer_readable.should match regex
    end
  end
  describe "#created_at_human_readable" do
    it "is human readable" do
      regex = /#{Time::DATE_FORMATS[:human].gsub(/%./, ".+")}/
      location.created_at_human_readable.should match regex
    end
  end
end
