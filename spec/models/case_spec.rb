require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Case do
  before(:each) do
    @valid_attributes = {
      :content => "value for content",
      :aim => 1,
      :emergency => 1,
      :security => 1,
      :kind => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Case.create!(@valid_attributes)
  end
end
