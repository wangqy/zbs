require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe History do
  it "require handle" do
    h = History.new 
    h.save
    h.errors.on(:handle).should_not be_nil
  end

  it "require department_code if handle is turn" do
    h = History.new(:handle => 10)
    h.save
    h.errors.on(:department_code).should_not be_nil
  end

  it "require department_code if handle is apply" do
    h = History.new(:handle => 30)
    h.save
    h.errors.on(:department_code).should_not be_nil
  end
end
