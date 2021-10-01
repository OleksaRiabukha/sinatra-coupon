require 'bundler'
require 'rspec'
require 'rack/test'
require 'faker'
require 'database_cleaner/active_record'
require 'json-schema'

ENV['RACK_ENV'] = 'test'

Bundler.require(:default, :test)

require File.expand_path('../app.rb', __dir__)
Dir["#{settings.root}/*/*.rb"].each { |file| require file }
Dir["#{settings.root}/support/shared_examples/*/*.rb"].each { |file| require file }

def app
  CouponApp
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

