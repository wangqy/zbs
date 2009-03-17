require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Person do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :phone => "value for phone",
      :mobile => "value for mobile",
      :sex => 1,
      :email => "value for email",
      :address => "value for address"
    }
  end

  it "should create a new instance given valid attributes" do
    Person.create!(@valid_attributes)
  end
end
