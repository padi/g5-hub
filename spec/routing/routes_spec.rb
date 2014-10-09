require 'rails_helper'

describe 'Routes' do
  describe :clients_integration_settings do
    specify { expect({get: '/clients_integration_settings'}).to route_to(controller: 'clients_integration_settings', action: 'index') }
    specify { expect({get: '/clients_integration_settings/new'}).to route_to(controller: 'clients_integration_settings', action: 'new') }
    specify { expect({get: '/clients_integration_settings/3/edit'}).to route_to(controller: 'clients_integration_settings', action: 'edit', id: '3') }
    specify { expect({put: '/clients_integration_settings/3'}).to route_to(controller: 'clients_integration_settings', action: 'update', id: '3') }
    specify { expect({delete: '/clients_integration_settings/3'}).to route_to(controller: 'clients_integration_settings', action: 'destroy', id: '3') }
    specify { expect({post: '/clients_integration_settings/'}).to route_to(controller: 'clients_integration_settings', action: 'create') }
  end

  describe :locations_integration_settings do
    specify { expect({get: '/locations_integration_settings/3/edit'}).to route_to(controller: 'locations_integration_settings', action: 'edit', id: '3') }
    specify { expect({get: '/locations_integration_settings/3'}).to route_to(controller: 'locations_integration_settings', action: 'show', id: '3') }
    specify { expect({put: '/locations_integration_settings/3'}).to route_to(controller: 'locations_integration_settings', action: 'update', id: '3') }
    specify { expect({delete: '/locations_integration_settings/3'}).to route_to(controller: 'locations_integration_settings', action: 'destroy', id: '3') }
    specify { expect({post: '/locations_integration_settings/'}).to route_to(controller: 'locations_integration_settings', action: 'create') }
  end
end
