require 'sinatra'

class App < Sinatra::Base
  configure do
    set :root,  File.dirname(__FILE__)
    set :views, Proc.new { File.join(root, "/views") }
  end

  get '/talent' do
    erb :talent
  end
end
