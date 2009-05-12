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
end
