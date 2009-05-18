require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Record do
  before(:each) do
    @valid_attributes = {
      :kind => 1,
      :dail => "13988889999",
      :receive => "802",
      :wavfile => "some_path",
      :uniqueid => " 20090518222222123456789"
    }
  end

  it "should create a new instance given valid attributes" do
    Record.create!(@valid_attributes)
  end
end
