require 'spec_helper'

describe 'Routes' do
  describe :integration_settings do
    specify { expect({put: '/locations/1/integration_settings/3'}).to route_to(controller: 'integration_settings', action: 'update', location_id: '1', id: '3') }
    specify { expect({get: '/locations/1/integration_settings/3/edit'}).to route_to(controller: 'integration_settings', action: 'edit', location_id: '1', id: '3') }
    specify { expect({get: '/locations/1/integration_settings/new'}).to route_to(controller: 'integration_settings', action: 'new', location_id: '1') }
    specify { expect({post: '/locations/1/integration_settings'}).to route_to(controller: 'integration_settings', action: 'create', location_id: '1') }
  end
end
