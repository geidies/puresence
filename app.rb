$:.unshift File.join(File.dirname(__FILE__))
$:.unshift File.join(File.dirname(__FILE__), 'models')
require 'sinatra'
require 'models/status'
require 'json'

status = Status.instance

get '/' do
  @ticktock = status.get
  @message  = @ticktock ? "Jupp!" : "nope :("
  erb :index
end

get '/come' do
  status.set true
  redirect '/'
end

get '/go' do
  status.set false
  redirect '/'
end

get '/status' do
  content_type :json
  { :someone_there => status.get }.to_json
end
