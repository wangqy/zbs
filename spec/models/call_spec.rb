require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Call do

  before(:each) do
    @valid_attributes = {
      :callnumber => "13988889999",
      :calltag => "深电2009032400008",
      :timing => "2009-03-24 22:22:22".to_time,
      :title => "马可波罗__投诉__区长热线办公室",
      :content => "楼下太吵",
      :aim => 1,
      :emergency => 1,
      :security => 1,
      :kind => 1,
      :name => "马可波罗", 
      :phone => "13988889999",
      :mobile => "13988889999",
      :sex => 1,
      :email => "mahb@cogentsoft.com.cn",
      :address => "简洁公司",
      :creator => users(:quentin),
      :modifier => users(:quentin)
    }
  end

  it "should create a new instance given valid attributes" do
    Call.create!(@valid_attributes)
  end

  it "should create a new case" do
    call = Call.new @valid_attributes
    call.init_case ""
    c = call.case
    c.should_not be_nil
    c.content.should == call.content
    c.phone.should == call.phone
    c.mobile.should == call.mobile
    c.callnumber.should == call.callnumber
  end

end
