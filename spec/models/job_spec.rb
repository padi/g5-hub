require 'rails_helper'

describe Job do
  let(:uid) { 'uid' }
  let(:urn) { 'urn' }
  let(:state) { 'state' }
  let(:integration_setting_uid) { 'isuid' }
  let(:message) { 'message' }
  let(:created_at) { '2014-11-10T14:57:19.546-08:00' }
  let(:updated_at) { '2014-11-10T15:57:19.546-08:00' }

  subject { Job.new(uid:                     uid, urn: urn, state: state,
                    integration_setting_uid: integration_setting_uid,
                    message:                 message, created_at: created_at, updated_at: updated_at) }

  its(:uid) { is_expected.to eq(uid) }
  its(:urn) { is_expected.to eq(urn) }
  its(:state) { is_expected.to eq(state) }
  its(:integration_setting_uid) { is_expected.to eq(integration_setting_uid) }
  its(:message) { is_expected.to eq(message) }
  its(:created_at) { is_expected.to eq(created_at) }
  its(:updated_at) { is_expected.to eq(updated_at) }
end