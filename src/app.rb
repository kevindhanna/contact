require 'sinatra'
require 'json'
require_relative 'models/model'

class App < Sinatra::Base
  configure do
    set :root,  File.dirname(__FILE__)
    set :views, proc { File.join(root, '/views') }
  end

  get '/talent' do
    location = params['location']

    talent = Model.find_by_location(location)

    erb :talent, locals: { talent: talent }
  end
end
