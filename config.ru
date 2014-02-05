require 'newrelic_rpm'
require 'new_relic/rack/agent_hooks'
require 'new_relic/rack/browser_monitoring'
require 'new_relic/rack/error_collector'

require_relative 'app'

use NewRelic::Rack::AgentHooks
use NewRelic::Rack::BrowserMonitoring
use NewRelic::Rack::ErrorCollector
run App.new