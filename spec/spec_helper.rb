require 'bundler'
require 'rspec'
require 'rack/test'
require 'faker'

ENV['RACK_ENV'] = 'test'

Bundler.require(:default, :test)

require File.expand_path('../app.rb', __dir__)
Dir['models/*.rb'].each { |file| require_relative file }
Dir['requests/*.rb'].each { |file| require_relative file }
Dir['factories/*.rb'].each { |file| require_relative file }
Dir['support/*.rb'].each { |file| require_relative file }


def app
  CouponApp
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
  end
end
