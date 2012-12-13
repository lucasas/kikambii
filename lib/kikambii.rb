require 'rake'

module Kikambii
  include Rake::DSL if defined? Rake::DSL
  load File.expand_path("../tasks/cucumber.rake", __FILE__)
end

require "kikambii/version"
require "kikambii/feature"
require "kikambii/feature_factory"
require "kikambii/runner"
