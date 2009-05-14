require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Workitem do
  before(:each) do
    @valid_attributes = {
      :store_id => "aaron",
      :conversation => conversations(:ma_complain),
      :creator => "quentin"
    }
  end

  it "should create a new instance given valid attributes" do
    Workitem.create!(@valid_attributes)
  end

  it "should send a message to user" do
    lambda do
      Workitem.send_msg
    end.should change(Msg, :count).by(1)
  end
end
