require 'spec_helper'

describe Vendor do
  it { should validate_uniqueness_of :name }
end