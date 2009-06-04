require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
describe LogsController do
  fixtures [:users,:logs]

  #Delete this example and add some real ones
  #it "should use LogsController" do
  #  controller.should be_an_instance_of(LogsController)
  #end
  
  before(:each) do
    login_as :cogentsoft
  end

  it "should goto index" do
    get :index
    response.should be_success
  end

  it "should query success" do
    get :index, :log => {:modulename => '用户', :operator => '高正', :operate => '1'}
    response.should be_success
  end

end
