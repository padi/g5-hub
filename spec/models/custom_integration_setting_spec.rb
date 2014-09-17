require 'spec_helper'

describe CustomIntegrationSetting do
  it { should belong_to :integration_setting }
  it { should validate_presence_of :name }
  it { should validate_presence_of :value }
end