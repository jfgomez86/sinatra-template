require 'rubygems'
require 'sinatra'
require 'environment'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  set :public, "#{File.dirname(__FILE__)}/public"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  def partial(template, options = {})
    options.merge!(:layout => false)
    erb("partials/#{template}".to_sym, options)
  end
end

get '/:page_name' do
  @page_name = params[:page_name]
  erb @page_name.to_sym
end

get '/' do
  @page_name = params[:page_name]
  erb :index
end
