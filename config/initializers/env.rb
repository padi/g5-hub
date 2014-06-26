ENV["G5_CONFIGURATOR_WEBHOOK_URL"] ||= case Rails.env
  when "production"  then "http://g5-configurator.herokuapp.com/consume_feed"
  when "development" then "http://g5-configurator.dev/consume_feed"
  when "test"        then "http:://g5-configurator.test/consume_feed"
end

ENV["CMS_UPDATE_PATH"] ||= case Rails.env
  when "production"  then  "/api/v1/clients/1/update"
  when "development" then  "/api/v1/foo"
  when "test"        then  "/api/v1/foo"
end
