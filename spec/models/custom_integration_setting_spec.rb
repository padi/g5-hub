require 'rails_helper'

describe CustomIntegrationSetting do
  it { is_expected.to belong_to :integration_setting }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :value }
end