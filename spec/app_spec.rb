ENV['RACK_ENV'] = 'test'

require 'app'
require 'minitest/autorun'
require 'rack/test'



describe "The puressence App" do
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
  it "returns 200 on getting the index" do
    get '/'
    expect( last_response ).to be_ok
  end

  it "return 302 when requesting /come" do
    get '/come'
    response = last_response
    expect(response.status).to be 302
  end

  it "has set absence when calling /come" do
    expect( Status.instance.get ).to be true
  end

  it "return 302 when requesting /go" do
    get '/go'
    response = last_response
    expect(response.status).to be 302
  end

  it "has set presence when calling /go" do
    expect( Status.instance.get ).to be false
  end

end
