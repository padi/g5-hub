Fabricator(:integration_setting) do
  etl_strategy_name 'EtlStrategies::Centershift4'
  lead_strategy_name 'LeadStrategies::SiteLink'
  inventory_vendor_user_name 'G-5TSite'
  inventory_vendor_password '1qaz@Wsx'
  inventory_vendor_endpoint 'https://slc.centershift.com/sandbox40/SWS.asmx?WSDL'
  lead_vendor_user_name 'G-5TSite'
  lead_vendor_password '1qaz@Wsx'
  lead_vendor_endpoint 'https://slc.centershift.com/sandbox40/SWS.asmx?WSDL'
  inventory_service_url 'http://localhost:5777/api/v1/storage_facilities'
  inventory_service_auth_token 'madeup'
end
