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
  begin
    erb @page_name.to_sym, :layout => "#{@page_name}_layout".to_sym
  rescue
    erb @page_name.to_sym rescue redirect("/")
  end
end

get '/:folder/:page_name' do
  @page_name = params[:page_name]
  begin
    erb @page_name.to_sym, :layout => "#{params[:folder]}/#{@page_name}_layout".to_sym
  rescue
    erb "#{params[:folder]}/#{@page_name}".to_sym rescue redirect("/")
  end
end

get '/:folder/' do
  @page_name = "#{params[:folder]}/index"
  begin
    erb @page_name.to_sym, :layout => "#{params[:folder]}/index_layout".to_sym
  rescue
    erb "#{params[:folder]}/index".to_sym rescue redirect("/")
  end
end

get '/' do
  @page_name = params[:page_name]
  erb :index
end
