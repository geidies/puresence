require 'redis'

class Status

  def initialize
    @redis = Redis.new( :url => ENV["REDISTOGO_URL"] )
  end

  def get
    status = @redis.get("status")
    if status != nil && status == 'true'
      true
    elsif status != nil && status == 'false'
      false
    else
      nil # file not found
    end
  end

  def set status
    if status
      @redis.set('status', 'true')
    else
      @redis.set('status', 'false')
    end
  end

end
