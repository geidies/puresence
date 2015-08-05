require 'redis'
require 'mock_redis'

class Redis::Implementation

  def self.connect *params
    if ENV["RACK_ENV"] == "production"
      return Redis.new( *params )
    elsif ENV["RACK_ENV"] == "test"
      return MockRedis.new( *params )
    elsif ENV["RACK_ENV"] == "docker"
      return MockRedis.new( *params )
    elsif ENV["RACK_ENV"] == "development"
      return MockRedis.new( *params )
    else
      raise "UNKNOWN ENVIRONMENT: #{ ENV['RACK_ENV'] }"
    end
  end
end
