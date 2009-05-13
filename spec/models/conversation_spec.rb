require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Conversation do
  before(:each) do
    @valid_attributes = {
      :title => "马波咨询房管新法规",
      :content => "来电人对新法规存在误解",
      :aim => 3,
      :emergency => 1,
      :security => 1,
      :kind => kinds(:normal),
      :creator => users(:aaron),
      :modifier => users(:aaron),
      :events => [
        Event.new(
          :category => 1,
          :timing => "2009-03-24 22:22:22".to_time,
          :content => "",
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
          ),
          :duty => Duty.new(
            :watchman => "阿郎",
            :receiver => "阿郎",
            :manager => "劳动局长"
          ),
          :creator => users(:aaron),
          :modifier => users(:aaron)
        )
      ]
    }
  end

  it "should create a new instance given valid attributes" do
    Conversation.create(@valid_attributes)
  end

  #保存时设置事件编号
  it "should init tag when create a new instance" do
    Conversation.create(@valid_attributes).tag.should_not be_nil
  end

  #计算截止日期
  it "should init finish date" do
    Conversation.create(@valid_attributes).finish_at.should_not be_nil
  end
end
