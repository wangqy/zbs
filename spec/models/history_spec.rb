require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe History do
  it "require handle" do
    h = History.new 
    h.save
    h.errors.on(:handle).should_not be_nil
  end
end
