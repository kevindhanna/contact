require 'sinatra'
require 'json'

class App < Sinatra::Base
  configure do
    set :root,  File.dirname(__FILE__)
    set :views, proc { File.join(root, '/views') }
  end

  get '/talent' do
    s = File.read('talent.json')
    talent = JSON.parse(s)

    names = if params['location']
              talent.map { |model| model['name'] if model['location'].downcase == params['location'].downcase }
            else
              talent.map { |model| model['name'] }
            end

    erb :talent, locals: { names: names }
  end
end
