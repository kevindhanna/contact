require 'sinatra'

class App < Sinatra::Base
  configure do
    set :root,  File.dirname(__FILE__)
    set :views, Proc.new { File.join(root, "/views") }
  end

  get '/talent' do
    names = ["Homer Simpson", "Frank Reynolds", "Diane Nguyen", "Krusty the Clown"]
    erb :talent, locals: {names: names}
  end
end
