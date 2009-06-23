require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Resource do
  fixtures :resources

  before(:each) do
    @valid_attributes = {
    }
  end

  it "should get user's menu hash" do
    menu_hash = {
      resources(:system) => [
        resources(:departments),
        resources(:users),
        resources(:logs),
        resources(:notices)
      ]
    }
    Resource.menu_hash_from(users(:admin)).should == menu_hash
  end
end
