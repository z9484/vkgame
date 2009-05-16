ENV["SHOES_ENV"] = "test"

require 'rubygems'
require 'test/unit'
require 'activesupport'
require 'active_support/test_case'
require 'machinist'
require 'mocha'

require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require 'blueprints'
