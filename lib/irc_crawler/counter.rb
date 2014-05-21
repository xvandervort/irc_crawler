require 'active_support'
require 'active_support/core_ext'

class Counter
  attr_reader :duration, :limit, :counter, :start_time, :end_time
  
  def initialize(params = {})
    @duration = params[:duration]
    @end_time = Time.current.advance(minutes: @duration) unless @duration.nil?
    @limit = params[:limit]
    @counter = 0
    @end_time 
  end
  
  # updates counter
  def increment
    @counter += 1
  end
  
  #checks to see if there is a need to stop
  def stop_on_limits
    if limit_reached? 
      raise StandardError, "Limit reached"
    elsif duration_elapsed?
      raise StandardError, "Time has elapsed."
    end
  end
  
  def check_stop_conditions
    limit_reached? || duration_elapsed?
  end
  
  private
  
  # true means the limit has been reached
  def limit_reached?   
    !(@counter.nil? || @counter < @limit)
  end
  
  def duration_elapsed?
    current_time = Time.now.to_i
    !(@end_time.nil? || current_time < @end_time.to_i)
  end
end