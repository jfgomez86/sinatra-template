require "rubygems"
require "bundler/setup"
require "compass"
require "yaml"
require "ninesixty"

require "sinatra" unless defined?(Sinatra)
require "haml"

require "dm-core"
require "dm-timestamps"
require "dm-validations"
require "dm-aggregates"
require "dm-migrations"

configure do
  AppRoot = File.dirname(__FILE__)
  database_settings = OpenStruct.new(YAML.load_file("#{AppRoot}/config/database.yml")[Sinatra::Base.environment])

  SiteConfig = OpenStruct.new(
                 :title => 'Application Name',
                 :author => 'Author',
                 :db => database_settings,
                 :url_base => 'http://localhost:4567/'
               )

  # load models
  $LOAD_PATH.unshift("#{AppRoot}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }

  DataMapper::Logger.new($stdout, :debug) if Sinatra::Base.environment == "development"
  DataMapper.setup(:default, "postgres://#{SiteConfig.db.user}:#{SiteConfig.db.password}@#{SiteConfig.db.host}/#{SiteConfig.db}_#{Sinatra::Base.environment}")

end
