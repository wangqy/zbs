require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Case do
  before(:each) do
    @valid_attributes = {
      :callnumber => "value for callnumber",
      :mobile => "value for mobile",
      :phone => "value for phone",
      :content => "value for content"
    }
  end

  it "should create a new instance given valid attributes" do
    Case.create!(@valid_attributes)
  end
end
