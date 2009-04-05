require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CallsController do
  before(:each) do
    login_as :aaron
    @valid_call = {
      :call => { 
        :callnumber => "13988889999",
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
      get 'new', :callnumber => "13988889999"
      assigns[:call].callnumber.should_not be_nil
      response.should be_success
    end
  end

  it "should be list" do
    get 'index'
    response.should be_success
  end

  describe "save call" do
    it "should save creator and modifier" do
      post :create, @valid_call 
      call = assigns[:call]
      call.creator.should == "aaron"
      call.modifier.should == "aaron"
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
      assigns[:call].modifier.should == "aaron"
    end
  end

  describe "list call" do
    it "should view a call" do
      get :show, :id => events(:complain).id
      assigns[:call].should == events(:complain)
      response.should be_success
    end

    it "should delete a call" do
      request.env["HTTP_REFERER"] = "/calls"
      post :destroy, :id => events(:complain).id
      response.should be_redirect
    end
  end
end
