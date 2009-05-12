require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Event do
  before(:each) do
    @valid_attributes = {
      :conversation => conversations(:ma_complain),
      :category => 1,
      :timing => "2009-03-24 22:22:22".to_time,
      :content => "",
      :creator => users(:aaron),
      :modifier => users(:aaron),
      :person => Person.new(
        :name => "马波",
        :cardno => "441521198205120045",
        :sex => 1,
        :phone => "0755-26741022",
        :mobile => "13988889999",
        :email => "mahb@cogentsoft.com.cn",
        :address => "深圳南山",
        :jobunit => "高正软件",
        :creator => users(:aaron),
        :modifier => users(:aaron)
      )
    }
  end

  it "should create a new instance given valid attributes" do
    Event.create(@valid_attributes)
  end

  #可以正确判断事件是联系人主动来电(来访)还是机关人员回电(回访)
  it "should recognize category" do
    events(:ma_complain_call).is_in?.should be_true
    events(:ma_complain_reply_call).is_out?.should be_true
  end
end
