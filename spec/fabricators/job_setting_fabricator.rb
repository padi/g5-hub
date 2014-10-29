Fabricator(:job_setting) do
  frequency 3
  frequency_unit { FrequencyUnit.where(name: 'minutes', minutes_multiplier: 1).first_or_create }
end