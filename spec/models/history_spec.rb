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


  #发送短信(只有转办,申请办结,退回,退回重办才发送短信)
  it "need to send a message" do
    Enum::HANDLE[1].each do |handle|
      history = History.new(:handle => handle)
      if %w(10 30 40 41).include?handle.to_s
        history.is_need_msg?.should be_true
      else
        history.is_need_msg?.should be_false
      end
    end
  end
end
