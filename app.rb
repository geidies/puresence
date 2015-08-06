$:.unshift File.join(File.dirname(__FILE__))
$:.unshift File.join(File.dirname(__FILE__), 'models')
require 'sinatra'
require 'models/status'
require 'json'

status = Status.instance

get '/' do
  @status = status.get
  if @status == 'plan'
    @message = "Arriving in #{(status.eta - Time.now.utc.to_i) / 60} minutes"
  else
    @message = @status ? "Jupp!" : "nope :("
  end
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

get '/plan/:time' do
  status.plan params[:time].to_i * 60
  redirect '/'
end
