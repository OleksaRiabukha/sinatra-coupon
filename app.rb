require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'rack/protection'
require 'sinatra/json'
require 'json'
require 'jsonapi/serializer'

require 'pry' unless ENV['APP_ENV'] == 'production'

['./lib/*.rb', './config/*.rb', './models/*.rb', './controllers/*.rb', './serializers/*.rb'].each do |files|
  Dir[files].each { |file| require_relative file }
end

class CouponApp < Sinatra::Base

  use Rack::Session::Pool

  set :root         , File.dirname(__FILE__)

  set :dump_errors  , false
  set :logging      , true
  set :raise_errors , true

  use Rack::Protection
end
