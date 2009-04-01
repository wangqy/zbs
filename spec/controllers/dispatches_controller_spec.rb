require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DispatchesController do
  before(:each) do
    login_as :cogentsoft
    @valid_attributes = {
      :id => events("complain").id,
      :history => {
        :handle => "10",
        :department_code => "111"
      }
    }
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :id => events("complain").id
      response.should be_success
    end
  end

  describe "save dispatch" do
    it "should set state to 1" do
      post :create, @valid_attributes
      assigns[:event].state.should == 1
    end

    #转办
    it "should be turn" do
      lamb = lambda do
        post :create, @valid_attributes.merge(:history => {:handle => 10}) 
      end
      lamb.should change(Workitem, :count).by(1)
      lamb.should change(History, :count).by(1)
    end

    #自己办理
    it "should deal by himself" do
      lamb = lambda do
        post :create, @valid_attributes.merge(:history => {:handle => 20})
      end
      lamb.should change(Workitem, :count).by(1)
      lamb.should change(History, :count).by(1)
    end

    #直接办结
    it "should be finish" do
      lamb = lambda do
        post :create, @valid_attributes.merge(:history => {:handle => 90})
      end
      lamb.should_not change(Workitem, :count)
      lamb.should change(History, :count).by(1)
    end
  end
end
