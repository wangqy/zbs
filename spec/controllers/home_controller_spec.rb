require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do
  fixtures :users

  before(:each) do
    login_as :cogentsoft
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
end
