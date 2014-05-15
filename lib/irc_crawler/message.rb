require 'json'

# purpose of this class is to organize message data and translate into different formats
class Message
  attr_reader :raw
  
  def initialize(prms = {})
    @raw = prms[:raw] || prms['raw'] || ''
  end
end
