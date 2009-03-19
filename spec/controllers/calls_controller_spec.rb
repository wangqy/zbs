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
end
