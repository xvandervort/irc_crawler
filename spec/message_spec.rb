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
        m1.timestamp.should be_a_kind_of(Float)
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
        m1 = Message.new raw: @raw_data, nick: @nick, text: @text
        jout = m1.to_json
        # for purpose of comparisons, parse it.
        jhsh = JSON.parse jout
        jhsh.should be_a_kind_of(Hash)
        
        # check the value
        jhsh['ip'].should == @ip
        jhsh['text'].should == @text
        jhsh['nick'].should == @nick
        jhsh['timestamp'].should_not be(nil)
        jhsh['raw'].should == @raw_data
      end
      
      it "should output a hash" do
        m1 = Message.new raw: @raw_data, nick: @nick, text: @text
        
        hsh = m1.to_h
        hsh.should be_a_kind_of(Hash)
        
        # and then check the values
        hsh[:nick].should == @nick
        hsh[:text].should == @text
        hsh[:raw].should == @raw_data
        hsh[:ip].should == @ip
        hsh[:timestamp].should be_a_kind_of(Float)
      end
      
      it "should output quoted csv" do
        # standard field order = timestamp, nick, ip, text, raw_data
        m1 = Message.new raw: @raw_data, nick: @nick, text: @text
        target = "\"#{ m1.timestamp }\", \"#{ @nick }\", \"#{ @ip }\", \"#{ @text }\", \"#{ @raw_data }\""
        out = m1.to_csv
        out.should == target
      end
      
      describe "to_format" do
      
        it "should output a hash when told" do
          m1 = Message.new raw: @raw_data, nick: @nick, text: @text
          out = m1.to_format('hash')
          out.should be_a_kind_of(Hash)
        end
        
        it "should output a json when told" do
          m1 = Message.new raw: @raw_data, nick: @nick, text: @text
          out = m1.to_format('json')
          outh = JSON.parse(out)
          outh.should be_a_kind_of(Hash)
        end
        
        it "should output text only when told" do
          m1 = Message.new raw: @raw_data, nick: @nick, text: @text
          out = m1.to_format('text-only')
          out.should == @text
        end
        
        it "should output text only when told" do
          m1 = Message.new raw: @raw_data, nick: @nick, text: @text
          out = m1.to_format('csv')
          out.should == target = "\"#{ m1.timestamp }\", \"#{ @nick }\", \"#{ @ip }\", \"#{ @text }\", \"#{ @raw_data }\""
        end
      end
    end
  end
end