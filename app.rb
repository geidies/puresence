require 'sinatra'

@ticktock = true

get '/' do
  @ticktock = !@ticktock
  erb :index
end
