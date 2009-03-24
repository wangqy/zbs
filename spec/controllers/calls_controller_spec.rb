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
end
