Vendor.where(name: 'SiteLink').first_or_create

FrequencyUnit.where(name: 'Minutes', minutes_multiplier: 1).first_or_create
FrequencyUnit.where(name: 'Hours', minutes_multiplier: 60).first_or_create
FrequencyUnit.where(name: 'Days', minutes_multiplier: 60*24).first_or_create