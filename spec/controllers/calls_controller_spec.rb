require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CallsController do
  before(:each) do
    login_as :aaron
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
      post :create, :call => { :name => "马可波罗" }
      call = Call.last
      call.creator.should == "aaron"
      call.modifier.should == "aaron"
    end
  end

  describe "update call" do
    it "should update modifier" do
      call = events(:complain)
      post :update, :call => { :name => "新马可波罗" }, :id => call.id
      Call.find(call).modifier.should == "aaron"
    end
  end
end
