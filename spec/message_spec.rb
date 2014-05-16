require 'spec_helper'

module MessageSpec
  describe Message do
    
    before(:each) do
      # Hmm. The raw data appears to lack a timestamp
      @raw_data = ":pyrotechnick!~pyrotechn@124-150-76-202.dyn.iinet.net.au PRIVMSG #Node.js :typescript is the exact opposite direction"
      @text = "typescript is the exact opposite direction"
      @nick = "pyrotechnick"
      @ip = '124-150-76-202.dyn.iinet.net.au'
    end
    
    describe "initialization params" do
      it "remembers the raw data" do
        m1 = Message.new raw: @raw_data
        m1.raw.should equal(@raw_data), "Why does raw not have the raw data?"
      end
      
      it "remembers the nick" do
        m1 = Message.new nick: @nick
        m1.nick.should == @nick 
      end
      
      it "pulls nick from the raw data if not given separately" do
        m1 = Message.new raw: @raw_data
        m1.nick.should == @nick 
      end
      
      it "leaves nick empty when data not given" do
        m1 = Message.new 
        m1.nick.should == "" 
      end
      
      it "should store a timestamp" do
        m1 = Message.new raw: @raw_data
        m1.timestamp.should_not be(nil)
        m1.timestamp.should be_a_kind_of(Fixnum)
      end
      
      it "should store message text" do
        m1 = Message.new raw: @raw_data, nick: @nick, text: @text
        m1.text.should == @text
      end
      
      it "should extract message text from raw if necessary" do
        m1 = Message.new raw: @raw_data, nick: @nick
        m1.text.should == @text
      end
      
      it "should extract ip address from raw if possible" do
        m1 = Message.new raw: @raw_data, nick: @nick
        m1.ip.should == @ip
      end
    end
    
    describe "output formats" do
      it "should output json" do
        pending
      end
    end
  end
end