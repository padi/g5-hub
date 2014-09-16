Fabricator(:integration_setting) do
  etl_strategy_name {'EtlStrategies::Centershift4'}
  vendor_user_name {'G-5TSite'}
  vendor_password {'1qaz@Wsx'}
  vendor_endpoint {'https://slc.centershift.com/sandbox40/SWS.asmx?WSDL'}
  inventory_service_url {'http://localhost:5777/api/v1/storage_facilities'}
end
