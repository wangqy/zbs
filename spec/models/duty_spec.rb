require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Duty do
  before(:each) do
    @valid_attributes = {
      :watchman => "阿郎",
      :receiver => "阿郎",
      :manager => "劳动局长",
      :event => Event.last
    }
  end

  it "should create a new instance given valid attributes" do
    Duty.create!(@valid_attributes)
  end
end
