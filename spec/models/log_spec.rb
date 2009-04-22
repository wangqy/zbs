require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Log do
  before(:each) do
    @valid_attributes = {
      :operate => 1,
      :modulename => 'User',
      :objectid => User.last.id,
      :operatedate => Time.now,
      :ip => '127.0.0.1',
      :operator => User.last
    }
  end

  it "should create a new instance given valid attributes" do
    Log.create!(@valid_attributes)
  end
end
