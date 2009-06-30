require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Online do
  before(:each) do
    @valid_attributes = {
      :user_id => users(:cogentsoft).id,
      :actived_at => Time.now
    }
  end

  it "should show user online" do
    Online.create!(@valid_attributes)
    Online.now?(users(:cogentsoft)).should be_true
    Online.now?(users(:admin)).should be_false
  end
end
