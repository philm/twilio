require 'spec_helper'

describe "Stats" do
  before(:all) do
    Twilio.connect('mysid', 'mytoken')
  end
  
  it "gets summary stats for calls in current account" do
    response0, url0 = stub_get(:calls_pg0, 'Calls', :query => {:PageSize => '2', :page => '0'})
    response1, url1 = stub_get(:calls_pg1, 'Calls', :query => {:PageSize => '2', :page => '1'})
    
    Twilio::Stats.calls(:PageSize => 2).should == {"4156767950"=>{:count=>2, :duration=>50, :price=>100}, "4156767975"=>{:count=>2, :duration=>85, :price=>170}, :total_count=>4, :total_duration=>135, :total_price=>270}
    WebMock.should have_requested(:get, url0).with(:query => {:PageSize => '2', :page => '0'})
    WebMock.should have_requested(:get, url1).with(:query => {:PageSize => '2', :page => '1'})
  end
  
end

