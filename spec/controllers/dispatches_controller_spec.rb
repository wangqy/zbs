require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DispatchesController do
  before(:each) do
    login_as :cogentsoft
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :id => events("complain")
      response.should be_success
    end
  end

  describe "save dispatch" do
    it "should set state to 1" do
      post :create, :id => events("complain"), :handle => 3
      assigns[:event].state.should == 1
    end

    #转办
    it "should insert a workitem while handle=1" do
      lambda do
        post :create, :id => events("complain"), :handle => 1
        #ArWorkitem is asynchronous
        sleep 0.5
      end.should change(OpenWFE::Extras::ArWorkitem, :count).by(1)
    end

    #自己办理
    it "should insert a workitem while handle=2" do
      lambda do
        post :create, :id => events("complain"), :handle => 2
        #ArWorkitem is asynchronous
        sleep 0.5
      end.should change(OpenWFE::Extras::ArWorkitem, :count).by(1)
    end


    #直接办结
    it "should not insert a workitem while handle=3" do
      lambda do
        post :create, :id => events("complain"), :handle => 3
      end.should_not change(OpenWFE::Extras::ArWorkitem, :count)
    end
  end

end
