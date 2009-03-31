require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WorkitemsController do
  set_fixture_class :ar_workitems => "OpenWFE::Extras::ArWorkitem"

  before(:each) do
    login_as :aaron
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
      get 'edit', :id => ar_workitems(:complain_workitem)
      assigns[:event].should_not be_nil
      assigns[:event].workitem_id.should_not be_nil
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "should be successful" do
      get 'update', :id => ar_workitems(:complain_workitem)
      response.should redirect_to(workitems_path)
    end
  end
end
