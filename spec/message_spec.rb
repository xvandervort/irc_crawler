require 'spec_helper'

module MessageSpec
  describe Message do
    describe "initialization params" do
      before(:each) do
        # Hmm. The raw data appears to lack a timestamp
        @raw_data = ":pyrotechnick!~pyrotechn@124-150-76-202.dyn.iinet.net.au PRIVMSG #Node.js :typescript is the exact opposite direction"
        @params=["#Node.js", "typescript is the exact opposite direction"]
        @nick = "pyrotechnick"
      end
      
      it "remembers the raw data" do
        m1 = Message.new raw: @raw_data
        m1.raw.should equal(@raw_data), "Why does raw not have the raw data?"
      end
    end
  end
end
