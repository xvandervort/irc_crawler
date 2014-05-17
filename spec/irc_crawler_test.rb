require 'spec_helper'

module IrcCrawlerSpec
  include IrcCrawler
  describe "parameters" do
    
    before(:each) do
      # Numbers provided here will always be different from defaults
      @_duration = 50
      @_limit = 10
      @_server = 'someirc.net'
      @_nick = 'BrainBoy'
      @_port = 6667
      @_channels = ['#bitcoin', '#security']
      @_format = 'text-only'  # not yet implemented!
      @_outfile = 'output.json' # there is no default since the default output location is the screen
      
      @params = { duration: @_duration,
                  limit: @_limit,
                  server: @_server,
                  nick: @_nick,
                  port: @_port,
                  channels: @_channels,
                  format: @_format,
                  outfile: @_outfile}
      
      set_params @params
    end
    
    it "should remember duration" do
      @duration.should_not be(nil)
      @duration.should == @_duration
    end
    
    it "should remember limit" do
      @limit.should_not be(nil)
      @limit.should == @_limit
    end
    
    it "should remember server" do
      @server.should_not be(nil)
      @server.should == @_server
    end
    
    it "should remember nick" do
      @nick.should_not be(nil)
      @nick.should == @_nick
    end
    
    it "should remember port" do
      @port.should_not be(nil)
      @port.should == @_port
    end
    
    it "should remember channel array" do
      @channels.should_not be(nil)
      @channels.should == @_channels
    end
    
    it "should add missing pound sign to channel" do
      set_params @params.merge({ channels: ['booze']})
      @channels.should_not be(nil)
      @channels.should == ['#booze']
    end
    
    it "should remember output format" do
      @format.should_not be(nil)
      @format.should == @_format
    end
    
    it "should remember output file format" do
      @outfile.should_not be(nil)
      @outfile.should == @_outfile
    end
  end
end