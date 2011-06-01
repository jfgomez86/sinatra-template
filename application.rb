require 'rubygems'
require 'sinatra'
require 'environment'

configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = "views"
  end

  set :views, "#{File.dirname(__FILE__)}/views"
  set :public, "#{File.dirname(__FILE__)}/public"
  set :haml, {:format => :html5}
  set :sass, Compass.sass_engine_options
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

not_found do
  "404 - This page was not found"
end

helpers do
  def partial(template, options = {})
    options.merge!(:layout => false)
    haml("partials/#{template}".to_sym, options)
  end
end

get '/:page_name' do
  @page_name = params[:page_name]
  begin
    haml @page_name.to_sym
  rescue Errno::ENOENT
    raise Sinatra::NotFound
  end
end

get '/' do
  @page_name = params[:page_name]
  haml :index
end

get ':stylesheet.css' do
  content_type 'text/css'
  begin
    sass params[:stylesheet].to_sym
  rescue
    "Stylesheet '#{params[:stylesheet]}' not found."
  end
end
