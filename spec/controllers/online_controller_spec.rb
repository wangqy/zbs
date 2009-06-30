require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OnlineController do
  describe "GET 'index'" do
    it "should be successful" do
      login_as :cogentsoft
      get 'index'
      response.should be_success
    end
  end
end
