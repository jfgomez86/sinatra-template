require 'rubygems'
require 'bundler/setup'
require 'compass'
require 'ninesixty'

require 'sinatra' unless defined?(Sinatra)
require 'haml'

require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-migrations'

configure do
  SiteConfig = OpenStruct.new(
                 :title => 'Application Name',
                 :author => 'Name',
                 :db => 'application_name',
                 :url_base => 'http://localhost:4567/'
               )

  # load models
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }

  DataMapper::Logger.new($stdout, :debug) if Sinatra::Base.environment == "development"
  DataMapper.setup(:default, "postgres://user:password@localhost/#{SiteConfig.db}_#{Sinatra::Base.environment}")

end
