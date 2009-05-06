require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sequence do
  it "should get a number" do
    Sequence.get.should_not be_nil
  end
  
  it "should get a event tag" do
    Sequence.case_tag.size.should == 16
  end
end
