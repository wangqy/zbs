require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe History do
  it "require creator" do
    h = History.create 
    h.errors.on(:creator).should_not be_nil
  end
  
  it "require handle" do
    h = History.create 
    h.errors.on(:handle).should_not be_nil
  end

  it "require department if handle is turn" do
    h = History.create(:handle => 10)
    h.errors.on(:department_id).should_not be_nil
  end

  it "require department if handle is apply" do
    h = History.create(:handle => 30)
    h.errors.on(:department_id).should_not be_nil
  end
end
