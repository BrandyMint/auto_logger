$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'bundler/setup' # Set up gems listed in the Gemfile.

Bundler.require(:development)
require "auto_logger"

require "minitest/autorun"
