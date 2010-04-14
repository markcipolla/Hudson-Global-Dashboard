PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

require 'capybara/cucumber'
require 'spec/expectations'

##
# You can hanlde all padrino applications using instead:
#   Padrino.application
Capybara.app = HudsonDashboard.tap { |app|  }
