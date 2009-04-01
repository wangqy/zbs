require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WorkitemsController do

  before(:each) do
    login_as :aaron
    @valid_attributes = {
      :id => workitems("complain_workitem").id,
      :history => {
        :handle => "10"
      }
    }
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      assigns[:list].should_not be_nil
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id => workitems(:complain_workitem).id
      assigns[:workitem].should_not be_nil
      assigns[:event].should_not be_nil
      response.should be_success
    end
  end

  describe "POST 'update'" do
    it "should be successful" do
      put 'update', @valid_attributes
      response.should redirect_to(workitems_path)
    end
    
    #转办
    it "should be turn" do
      lamb = lambda do
        put 'update', @valid_attributes.merge(:history => {:handle => 10})
        response.should redirect_to(workitems_path)
      end
      lamb.should change(Workitem, :count).by(1)
      lamb.should change(History, :count).by(1)
    end
  end
end
