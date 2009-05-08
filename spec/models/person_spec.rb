require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Person do
  before(:each) do
    @valid_attributes = {
      :name => '张先生',
      :phone => '26741022',
      :cardno => '441521198311110022',
      :mobile => '13988889999',
      :sex => 1,
      :email => 'mahb@cogentsoft.com.cn',
      :address => '深圳南山',
      :jobunit => '高正软件',
      :creator => users(:aaron),
      :modifier => users(:aaron)
    }
  end

  it "should create a new instance given valid attributes" do
    Person.create!(@valid_attributes)
  end

  it "should get the person's info" do
    people(:ma).to_s.should == "男 0755-26741022 13988889999 深圳南山 高正软件"
  end
end
