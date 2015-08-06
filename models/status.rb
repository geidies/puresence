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
    elsif status != nil && status == 'plan'
      status
    else
      false # file not found
    end
  end

  def set new_status, expire = 28800
    if new_status == true
      @@redis.setex('status', expire, 'true')
    elsif new_status == false
      @@redis.set('status', 'false')
    elsif new_status == 'plan'
      unless get == true
        @@redis.setex('status', expire, 'plan')
      end
    end
  end

  def plan expire_in_seconds
    t0 = Time.now.utc.to_i
    expires_at = t0 + expire_in_seconds
    @@redis.setex 'eta', expires_at, expires_at
    set 'plan', expire_in_seconds
  end

  def eta
    @@redis.get( 'eta' ).to_i
  end

end
