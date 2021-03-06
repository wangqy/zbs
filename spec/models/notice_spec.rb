require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Notice do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :content => "value for content",
      :deployed => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Notice.create!(@valid_attributes)
  end
end
