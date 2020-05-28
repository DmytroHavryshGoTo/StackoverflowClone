require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StackoverflowClone
  class Application < Rails::Application

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.generators do |g|
      g.test_framework :rspec
      g.helper_specs false
      g.controller_specs true
      g.view_specs false
      g.routing_specs false
      g.fixtures true
      g.request_specs true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
