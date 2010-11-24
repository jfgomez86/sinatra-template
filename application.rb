require 'rubygems'
require 'sinatra'
require 'environment'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  set :public, "#{File.dirname(__FILE__)}/public"

  Compass.configuration do |config|
    config.project_path     = File.dirname(__FILE__)
    config.sass_dir         = File.join('views', 'stylesheets')
    config.images_dir       = File.join('public', 'images')
    config.http_images_path = "/images"
    config.http_stylesheets_path = "/stylesheets"
  end
end

get "/stylesheets/:name.css" do
  content_type 'text/css', :charset => 'utf8'

  sass :"stylesheets/#{params[:name]}", Compass.sass_engine_options
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

# root page
get '/' do
  haml :root
end
