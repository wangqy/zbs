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
  end

end
