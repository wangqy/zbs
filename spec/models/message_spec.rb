require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Message do
  before(:each) do
    @valid_attributes = {
      :conversation => conversations(:ma_complain),
      :user => users(:aaron),
      :creator => users(:aaron)
    }
  end

  it "should create a new instance given valid attributes" do
    m = Message.create!(@valid_attributes)
    m.content.should_not be_nil
  end

  it "should send the unsended message" do
    lambda do
      messages(:depart).is_sended.should == false
      Message.send_msg
      messages(:depart).reload.is_sended.should == true
    end.should change(Msg, :count).by(1)
  end
end
