require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventsController do
  before(:each) do
    login_as :aaron
    @valid_attribute = {
      :event => {
        :conversation_id => conversations(:ma_complain).id,
        :person_id => people(:ma).id,
        :category => 1,
        :timing => "2009-03-24 22:22:22",
        :content => "咨询事件进展情况",
        :wavfile => ""
      },
      :phone => '3324768'
    }
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :event => {:conversation_id => conversations(:ma_complain).id}, :phone => '3324768'
      assigns[:conversation].should_not be_nil
      assigns[:event].timing.should_not be_nil
      #值班室信息
      duty = assigns[:duty]
      duty.watchman.should_not be_nil
      duty.receiver.should_not be_nil
      duty.manager.should_not be_nil
      response.should be_success
    end

    #提供联系人列表,默认显示联系电话相同的联系人
    it "should get person" do
      get 'new', :event => {:conversation_id => conversations(:ma_complain).id}, :phone => '3324768'
      assigns[:event][:person_id].should_not be_nil
    end
  end

  describe "save event" do
    it "should be successful" do
      lambda do
        post :create, @valid_attribute
        response.should be_success
        assigns[:event].duty.should_not be_nil unless params[:duty].blank?
      end.should change(Event, :count).by(1)
    end

    #保存事件时,将新的联系电话加到所选联系人的"联系电话"字段中
    it "should save person's new phone" do
      post :create, @valid_attribute
      Person.find(assigns[:event].person_id).phone.should =~ /3324768/
    end
  end

  describe "update event" do
    it "should be successful" do
      @valid_attribute.merge!(:id => events(:ma_complain_call))
      @valid_attribute[:event].merge!(:content => '咨询最新情况')
      post :update, @valid_attribute.merge!(:id => events(:ma_complain_call))
      assigns[:event].content.should == '咨询最新情况'
      response.should be_success
    end
  end
end
