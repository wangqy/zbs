require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Workitem do
  before(:each) do
    @valid_attributes = {
      :store_id => "aaron",
      :conversation => conversations(:ma_complain),
      :creator => users(:quentin),
      :last_store => users(:quentin)
    }
  end

  it "should create a new instance given valid attributes" do
    Workitem.create!(@valid_attributes)
  end

  it "should send a message to user" do
    lambda do
      Workitem.send_msg
      Msg.last.SM_Content.should == "您的待办事项还有2个事件未处理,1个处于预警状态,请尽快处理."
    end.should change(Msg, :count).by(1)
  end
end
