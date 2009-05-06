require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ConversationsController do
  before(:each) do
    login_as :aaron
    @valid_attribute = {
      :conversation => { 
        :title => "马海波咨询新劳动法法规",
        :aim => 3,
        :emergency => 1,
        :security => 1,
        :content => "来电人对新法规存在误解",
        :kind_id => kinds(:normal)
      },
      :event => {
        :category => 1,
        :timing => "2009-03-24 22:22:22",
        :content => "",
        :wavfile => ""
      },
      :person => {
        :name => "马波",
        :cardno => "441521198205120045",
        :sex => 1,
        :phone => "0755-26741022",
        :mobile => "13988889999",
        :email => "mahb@cogentsoft.com.cn",
        :address => "深圳南山",
        :jobunit => "高正软件",
      },
      :duty => {
        :watchman => "阿郎",
        :receiver => "阿郎",
        :manager => "劳动局长"
      }
    }
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new, :phone => '13988889999', :category => '1'
      response.should be_success
      c = assigns[:conversation]
      event = assigns[:event]
      person = assigns[:person]
      duty = assigns[:duty]

      event.timing.should_not be_nil
      person.phone.should == '13988889999'
      duty.watchman.should_not be_nil
      duty.receiver.should_not be_nil
      duty.manager.should_not be_nil
    end
  end

  describe "GET 'index'" do
    it "should be search" do
      get :index, :phone => '13988889999'
      response.should be_success
      assigns[:list].should_not be_nil
    end
  end

  describe "save conversation" do
    it "should be successful" do
      lambda do
        post :create, @valid_attribute
        flash[:notice].should == "保存成功!"
      end.should change(Conversation, :count).by(1)
    end

  end

end
