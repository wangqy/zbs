require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Message do
  before(:each) do
    @valid_attributes = {
      :case => cases(:ma_complain),
      :user => users(:aaron),
      :creator => users(:aaron)
    }
  end

  it "should create a new instance given valid attributes" do
    m = Message.create!(@valid_attributes)
    m.content.should_not be_nil
  end
end
