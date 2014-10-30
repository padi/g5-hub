require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module G5Hub
  class Application < Rails::Application
    config.autoload_paths << "#{config.root}/lib"    # Settings in config/environments/* take precedence over those specified here.
    config.autoload_paths += %W(#{config.root}/app/models/concerns)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql



    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Heroku requires this to be false
    config.assets.initialize_on_precompile = false

    config.middleware.insert_before "Warden::Manager", "Rack::Cors" do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :options, :head]
      end
    end

    config.after_initialize do
      Rails.application.routes.default_url_options[:host] = ENV['HOST']
    end
  end
end
