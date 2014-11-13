ENV["CONFIGURATOR_WEBHOOK_URL"] ||= case Rails.env
  when "production"  then "http://g5-configurator.herokuapp.com/consume_feed"
  when "development" then "http://g5-configurator.dev/consume_feed"
  when "test"        then "http://g5-configurator.test/consume_feed"
end

ENV["CMS_UPDATE_PATH"] ||= case Rails.env
  when "production"  then  "/update"
  when "development" then  "/foo"
  when "test"        then  "/foo"
end

ENV["G5_UPDATABLE_PATH"] ||= case Rails.env
  when "production"  then  "/g5_updatable/update"
  when "development" then  "/foo"
  when "test"        then  "/foo"
end

ENV["APP_NAMESPACE"] ||= "g5"

ENV["HOST"] ||= case Rails.env
  when "production"  then "#{ENV['APP_NAMESPACE']}-hub.herokuapp.com"
  when "development"  then "hub.g5dxm.com"
  # when "development" then "localhost:3005"
  when "test"        then "localhost:3005"
end

