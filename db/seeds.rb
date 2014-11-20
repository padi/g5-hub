Vendor.where(name: 'SiteLink').first_or_create

FrequencyUnit.where(name: 'Minutes', minutes_multiplier: 1).first_or_create
FrequencyUnit.where(name: 'Hours', minutes_multiplier: 60).first_or_create
FrequencyUnit.where(name: 'Days', minutes_multiplier: 60*24).first_or_create

client = Client.create(name: 'Client 1',
              vertical: 'Apartments',
              domain_type: 'SingleDomainClient',
              city: 'New York',
              state: 'New York')
ClientsIntegrationSetting.create(vendor_action: 'inventory', client: client)
