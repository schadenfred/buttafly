require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "buttafly"

module Dummy
  class Application < Rails::Application

		config.autoload_paths += %W(#{config.root}/config/routes)

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
