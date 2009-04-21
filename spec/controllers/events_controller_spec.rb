require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventsController do
  before(:each) do
    login_as :aaron
    @valid_call = {
      :event => { 
        :callnumber => "13988889999",
        :calltag => "深电2009032400009",
        :timing => "2009-03-24 22:22:22".to_time,
        :name => "马可波罗",
        :title => "马可波罗__投诉__区长办公室",
        :content => "楼下太吵啦",
        :watchman => "阿朗",
        :receiver => "阿朗",
        :manager => "劳动局长"
      },
      :type => "Call"
    }
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :type => "Call"
      event = assigns[:event]
      event.timing.should_not be_nil
      #值班室信息
      event.watchman.should_not be_nil
      event.receiver.should_not be_nil
      event.manager.should_not be_nil
      response.should be_success
    end
    
    it "should be pop up" do
      dup_event = events(:complain).clone
      dup_event.timing = dup_event.timing.change(:hour => 8)
      dup_event.save
      
      get 'new', :callnumber => "13988889999", :type => "Call"
      assigns[:event].callnumber.should_not be_nil
      assigns[:list][0].should == dup_event.case
      response.should be_success
    end
  end

  it "should be list" do
    get 'index', :type => "Call"
    response.should be_success
  end

  describe "save event" do
    it "require callnumber" do
      @valid_call[:event].merge!(:callnumber => "")
      post :create, @valid_call
      assigns[:event].errors.on(:callnumber).should_not be_nil
      response.should be_success
    end

    it "require duty info" do
      @valid_call[:event].merge!(
        :watchman => "",
        :receiver => "",
        :manager => ""
      )
      post :create, @valid_call
      assigns[:event].errors.on(:watchman).should_not be_nil
      assigns[:event].errors.on(:receiver).should_not be_nil
      assigns[:event].errors.on(:manager).should_not be_nil
      response.should be_success
    end

    it "should save creator and modifier" do
      post :create, @valid_call
      event = assigns[:event]
      event.creator.should == users(:aaron)
      event.modifier.should == users(:aaron)
    end

    it "should continue save" do
      post :create, @valid_call.merge!(:commit => I18n.t('html.button.save'))
      response.should redirect_to(new_call_path)
    end
  end

  describe "update event" do
    it "should update modifier" do
      event = events(:complain)
      post :update, :event => { :name => "新马可波罗" }, :id => event.id, :type => "Call"
      assigns[:event].modifier.should == users(:aaron)
    end
  end

  describe "list event" do
    it "should view a event" do
      get :show, :id => events(:complain).id, :type => "Call"
      assigns[:event].should == events(:complain)
      response.should be_success
    end

    it "should delete a event" do
      lambda do
        request.env["HTTP_REFERER"] = "/calls"
        post :destroy, :id => events(:complain).id, :type => "Call"
        response.should be_redirect
      end.should change(Event, :count).by(-1)
    end

    it "should not be delete a dispatched event" do
      lambda do
        events(:complain).update_attribute(:state, 10)
        request.env["HTTP_REFERER"] = "/calls"
        post :destroy, :id => events(:complain).id, :type => "Call"
        response.should be_redirect
      end.should_not change(Event, :count)
    end
  end
end
