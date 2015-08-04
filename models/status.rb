require 'redis_implementation'
require 'singleton'

class Status

  include Singleton

  def initialize
    @@redis = Redis::Implementation.connect( :url => ENV["REDISTOGO_URL"] )
    if @@redis.get("status") == nil
      @@redis.set "status", false
    end
  end

  def get
    status = @@redis.get("status")
    if status != nil && status == 'true'
      true
    elsif status != nil && status == 'false'
      false
    else
      false # file not found
    end
  end

  def set status
    if status
      @@redis.setex('status', 28800, 'true')
    else
      @@redis.set('status', 'false')
    end
  end

end
