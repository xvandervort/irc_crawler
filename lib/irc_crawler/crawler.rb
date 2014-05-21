require_relative 'message'
require_relative 'writer'
require_relative 'counter'
require 'cinch'

module IrcCrawler
  class Crawler
    
    # Assumption: options have been validated before being sent in.
    def initialize(opts = {})
      @opts = opts
      @writer = Writer.new @opts[:format], @opts[:outfile]
      @count_checker = Counter.new @opts
    end
    
    def crawl
      @crawl = config_crawling(@opts, @writer, @count_checker) 
      @crawl.start
    end
    
    private
    
    def config_crawling(opts, writr, countr)
      bot = Cinch::Bot.new do
        configure do |c|
          c.server = opts[:server]
          # TODO: Stop ignoring port configuration or remove it as an option!
          c.channels = opts[:channels]
          c.nick = opts[:nick]
        end
        
        helpers do

        end
        
        on :message, /.*/ do |m|
          msg_parts = {
            raw: m.raw,
            nick: m.user.nick,
            text: m.params[1]
          }
          mess = Message.new msg_parts
          writr.write mess
          countr.increment
          if countr.check_stop_conditions
            puts "Stream complete"
            exit
          end
        end
      end
      
      bot
    end
  end
end