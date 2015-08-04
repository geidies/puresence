require 'sinatra'
require './models/status'


get '/' do
  status = Status.new
  @ticktock = status.get
  erb :index
end

get '/come' do
  status = Status.new
  status.set true
  redirect '/'
end

get '/go' do
  status = Status.new
  status.set false
  redirect '/'
end
