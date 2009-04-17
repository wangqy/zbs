require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Kind do
  before(:each) do
    @valid_attributes = {
      :name => "紧急事务"
    }
  end

  it "should create a new instance" do
    lambda do
      Kind.create!(@valid_attributes)
    end.should change(Kind, :count).by(1)
  end

  it "require name" do
    lambda do
      Kind.create
    end.should_not change(Kind, :count)
  end

  it "should create a child" do
    @valid_attributes.merge! :parent => kinds(:normal)
    Kind.create!(@valid_attributes)
  end
end
