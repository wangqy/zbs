require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RecordsController do
  before(:each) do
    login_as :aaron
  end

  it "should be index" do
    get :index
    response.should be_success
    assigns[:page].should_not be_nil
  end

  it "should create a dail in record" do
    lambda do
      get :create, :kind => 'dail_in', :dail => '13988889999', :receive => '802', :wavfile => 'some_path', :uniqueid => '20090518222222123456789'
      response.should redirect_to(conversations_url(:phone => '13988889999', :record_id => assigns[:record].id))
    end.should change(Record, :count).by(1)
  end

  it "should create a dail out record" do
    lambda do
      get :create, :kind => 'dail_out', :dail => '802', :receive => '13988889999', :wavfile => 'some_path', :uniqueid => '20090518222222123456789'
      response.should redirect_to(events_url(:phone => '13988889999', :record_id => assigns[:record].id))
    end.should change(Record, :count).by(1)
  end

end
  
