ENV["TEST"] = "true"
ENV["AUTOLOAD_SPROCKETS"] = "false"

PROJECT_ROOT_PATH = File.dirname(File.dirname(File.dirname(__FILE__)))
require "middleman-core"
require "middleman-core/step_definitions"

require 'middleman-target'

After do
  ENV['MIDDLEMAN_BUILD_TARGET'] = nil
end

Given /^build target is "(.*?)"$/ do |target_name|
  ENV['MIDDLEMAN_BUILD_TARGET'] = target_name
end
