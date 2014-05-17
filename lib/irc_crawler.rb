require "irc_crawler/version"
require 'irc_crawler/message'

module IrcCrawler
  DEFAULTS = {
    duration: 5,
    limit: 1000,
    server: "irc.freenode.org",
    nick: 'random_user',
    format: 'json'
  }
  
  # Output formats for which we have an adapter
  FORMATS = ['json', 'csv', 'text-only', 'hash']
  
  def set_params(prm = {})
    @duration   = prm[:duration] || prm['duration'] || DEFAULTS[:duration]
    @limit      = prm[:limit] || prm['limit'] || DEFAULTS[:limit]
    @server     = prm[:server] || prm['server'] || DEFAULTS[:server]
    @nick       = prm[:nick] || prm['nick'] || DEFAULTS[:nick]
    @port       = prm[:port] || prm['port'] || DEFAULTS[:port]
    channel_list   = prm[:channels] || prm['channels'] || config_fail("Channel list is mandatory")
    @channels   = channel_repair channel_list
    @format     = validate_format(prm)
  end
    
  private
  
  def config_fail(str = 'an error has occurred')
    raise ArgumentError, str
  end

  
  # IN: An array of channel names
  # Out: The same array but with every member preeded by a #
  def channel_repair(list)
    list.collect do |chan|
      chan[0] == '#' ? chan : "##{chan}"
    end
  end
  
  # IN: all the params.
  # OUT: a known format name
  def validate_format(parm)
    target = parm[:format] || parm['format']
    if target.nil?
      DEFAULTS[:format]
      
    else
      target.downcase!
      FORMATS.include?(target) ? target : config_fail("Please choose an output format from the following: #{ FORMATS.join(', ') }")
    end
  end
end
