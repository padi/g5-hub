Fabricator(:integration_setting) do
  strategy_name 'EtlStrategies::Centershift4'
  vendor_user_name 'G-5TSite'
  vendor_password '1qaz@Wsx'
  vendor_endpoint 'https://slc.centershift.com/sandbox40/SWS.asmx?WSDL'
end
