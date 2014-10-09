require 'rails_helper'

describe Vendor do
  it { is_expected.to validate_uniqueness_of :name }
end