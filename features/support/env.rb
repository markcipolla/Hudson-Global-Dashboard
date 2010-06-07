PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")
require 'spec/expectations'
require 'capybara/cucumber'

require 'gizmo'
require 'features/support/patches/capybara'
#require 'ruby-debug'
World(Gizmo::Helpers)

##
# You can handle all padrino applications using instead:
#   Padrino.application
Capybara.app = HudsonDashboard.tap { |app|  }

Capybara.default_selector = :xpath

Capybara.default_driver = :selenium

Capybara.app_host = 'http://localhost:3000'

Capybara.run_server = false