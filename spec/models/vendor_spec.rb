require 'rails_helper'

describe Vendor do
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to validate_presence_of :name }
end