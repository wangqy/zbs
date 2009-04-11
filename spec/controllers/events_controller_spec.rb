require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventsController do
  before(:each) do
    login_as :aaron
    @valid_call = {
      :call => { 
        :callnumber => "13988889999",
        :calltag => "深电2009032400009",
        :timing => "2009-03-24 22:22:22".to_time,
        :name => "马可波罗",
        :title => "马可波罗__投诉__区长办公室",
        :content => "楼下太吵啦"
      }
    }
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      assigns[:call].timing.should_not be_nil
      response.should be_success
    end
    
    it "should be pop up" do
      dup_event = events(:complain).clone
      dup_event.timing = dup_event.timing.change(:hour => 8)
      dup_event.save
      
      get 'new', :callnumber => "13988889999"
      assigns[:call].callnumber.should_not be_nil
      assigns[:list][0].should == dup_event.case
      response.should be_success
    end
  end

  it "should be list" do
    get 'index'
    response.should be_success
  end

  describe "save call" do
    it "require callnumber" do
      @valid_call[:call].merge!(:callnumber => "")
      post :create, @valid_call
      assigns[:call].errors.on(:callnumber).should_not be_nil
      response.should be_success
    end

    it "should save creator and modifier" do
      post :create, @valid_call 
      call = assigns[:call]
      call.creator.should == users(:aaron)
      call.modifier.should == users(:aaron)
    end

    it "should continue save" do
      post :create, @valid_call.merge!(:commit => I18n.t('html.button.save'))
      response.should redirect_to(new_call_path)
    end
  end

  describe "update call" do
    it "should update modifier" do
      call = events(:complain)
      post :update, :call => { :name => "新马可波罗" }, :id => call.id
      assigns[:call].modifier.should == users(:aaron)
    end
  end

  describe "list call" do
    it "should view a call" do
      get :show, :id => events(:complain).id
      assigns[:call].should == events(:complain)
      response.should be_success
    end

    it "should delete a call" do
      lambda do
        request.env["HTTP_REFERER"] = "/calls"
        post :destroy, :id => events(:complain).id
        response.should be_redirect
      end.should change(Event, :count).by(-1)
    end

    it "should not be delete a dispatched call" do
      lambda do
        events(:complain).update_attribute(:state, 10)
        request.env["HTTP_REFERER"] = "/calls"
        post :destroy, :id => events(:complain).id
        response.should be_redirect
      end.should_not change(Event, :count)
    end
  end
end