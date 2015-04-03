$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "propertybase_id"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
