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

  describe "POST 'update'" do
    
    #转办
    it "should be turn" do
      lambda do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 10, :department_code => "A001"}
        )
        response.should redirect_to(workitems_path)
      end.should_not change(Workitem, :count)
    end
  end
end
