require_relative 'boot'

require "rails"

# Frameworks
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require 'neo4j/railtie'
# require "sprockets/railtie"

# Require all the gems!
Bundler.require(*Rails.groups)

module CommuteCalculator
  class Application < Rails::Application
    # Only api middleware
    config.api_only = true

    # send logging to STDOUT for Docker
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.log_tags  = [:subdomain, :uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(logger)

    # Include lib at load for json token encoding
    config.autoload_paths << Rails.root.join('lib')

    # Include neo4j graph database generator
    config.generators { |g| g.orm :neo4j }
    config.neo4j.session.options = {initialize: { ssl: { verify: true }}}
  end
end
