require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'rack/protection'
require 'json'

Dir['./lib/*.rb'].each { |file| require_relative file }
Dir['./config/*.rb'].each { |file| require_relative file }
Dir['./models/*.rb'].each { |file| require_relative file }
Dir['./controllers/*.rb'].each { |file| require_relative file }
Dir['./routes/*.rb'].each { |file| require_relative file }

class CouponApp < Sinatra::Base

  use Rack::Session::Pool

  set :root         , File.dirname(__FILE__)

  set :dump_errors  , false
  set :logging      , true
  set :raise_errors , true

  use Rack::Protection
end
