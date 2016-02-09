require "sinatra/base"
require "tilt/erb"

class WebApp < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/../views'
  
  get '/' do
    erb :index
  end
end
