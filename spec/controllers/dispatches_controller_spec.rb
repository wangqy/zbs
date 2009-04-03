require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DispatchesController do
  before(:each) do
    login_as :cogentsoft
    @valid_attributes = {
      :id => events("complain").id,
      :history => {
        :handle => "10",
        :department_code => "A001"
      }
    }
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :id => events("complain").id
      response.should be_success
    end
  end

  describe "save dispatch" do
    it "require handle" do
      @valid_attributes[:history].merge!(:handle => "")
      post :create, @valid_attributes
      assigns[:history].errors.on(:handle).should_not be_nil
    end

    it "require department_code if handle is turn" do
      @valid_attributes[:history].merge!(:department_code => "")
      post :create, @valid_attributes
      assigns[:history].errors.on(:department_code).should_not be_nil
    end

    it "require department_code if handle is apply" do
      @valid_attributes[:history].merge!(:handle => "30", :department_code => "")
      post :create, @valid_attributes
      assigns[:history].errors.on(:department_code).should_not be_nil
    end

    #保存
    it "should be save" do
      lambda do
        post :create, @valid_attributes
        events(:complain).reload.state.should == 10
      end.should change(History, :count).by(1)
    end
    #转办
    it "should be turn" do
      lambda do
        post :create, @valid_attributes
        events(:complain).reload.state.should == 10
      end.should change(Workitem, :count).by(1)
    end

    #自己办理
    it "should deal by himself" do
      lambda do
        post :create, @valid_attributes.merge(:history => {:handle => 20})
        events(:complain).reload.state.should == 20
      end.should change(Workitem, :count).by(1)
    end

    #直接办结
    it "should be finish" do
      lambda do
        post :create, @valid_attributes.merge(:history => {:handle => 90})
        events(:complain).reload.state.should == 90
      end.should_not change(Workitem, :count)
    end
  end
end
