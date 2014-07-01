ENV["G5_CONFIGURATOR_WEBHOOK_URL"] ||= case Rails.env
  when "production"  then "http://g5-configurator.herokuapp.com/consume_feed"
  when "development" then "http://g5-configurator.dev/consume_feed"
  when "test"        then "http:://g5-configurator.test/consume_feed"
end

ENV["G5_UPDATABLE_PATH"] ||= case Rails.env
  when "production"  then  "/g5_updatable/update"
  when "development" then  "/foo"
  when "test"        then  "/foo"
end
