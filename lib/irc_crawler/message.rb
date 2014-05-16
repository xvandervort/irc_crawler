require 'json'

# purpose of this class is to organize message data and translate into different formats
class Message
  attr_reader :raw, :nick, :timestamp, :text, :ip
  
  def initialize(prms = {})
    @raw = prms[:raw] || prms['raw'] || ''
    @nick = prms[:nick] || prms['nick'] || find_nick(@raw) || ""
    @timestamp = Time.now.to_i
    @text = prms[:text] || prms['text'] || find_text(@raw) || ''
    @ip = find_ip(@raw)
  end
  
  
  private
  
  # attempts to pull nick out of the raw data
  # IN: a string from the cinch raw data field.
  def find_nick(r)
    unless r.empty? || r.nil?
      r =~ /:(.*)!/
      $1
    end
  end
  
  # attempts to pull text out of the raw data
  # IN: a string from the cinch raw data field.
  #     example: ":pyrotechnick!~pyrotechn@124-150-76-202.dyn.iinet.net.au PRIVMSG #Node.js :but, if you wanna use handlebars, may as well use express"
  # BUG: This will fail to get the whole message if there's a colon somewhere in it
  def find_text(r)
    unless r.empty? || r.nil?
      r.reverse =~ /^(.*?):/  # it's easier to match from the front than the rear
      $1.reverse
    end
  end
  
  # attempts to pull user ip address out of the raw data
  # IN: a string from the cinch raw data field.
  def find_ip(r)
    unless r.empty? || r.nil?
      r =~ /@(.*)PRIVMSG/
      $1.strip
    end
  end
end
