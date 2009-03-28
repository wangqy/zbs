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
end
