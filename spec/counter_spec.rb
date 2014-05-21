require 'spec_helper'
require_relative '../lib/irc_crawler/counter'

module CounterSpec
  
  describe Counter do
    
    it "should remember duration if provided" do
      co = Counter.new duration: 12
      co.duration.should == 12
    end
    
    it "should remember limit if provided" do
      co = Counter.new limit: 10
      co.limit.should == 10
    end
    
    it "should initialize counter at zero" do
      co = Counter.new limit: 10
      co.counter.should == 0
    end
    
    it "should not init end_time when no duration" do
      co = Counter.new limit: 10
      co.end_time.should be_a_kind_of(NilClass)
    end
    
    it "should not init limit when no limit given" do
      co = Counter.new duration: 10
      co.limit.should be_a_kind_of(NilClass)
    end
    
    it "should add one to counter when incrementing" do
      co = Counter.new limit: 10
      co.increment
      co.increment
      co.counter.should == 2
    end
  end
end