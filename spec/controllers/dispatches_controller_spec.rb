require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DispatchesController do
  before(:each) do
    login_as :cogentsoft
    @valid_attributes = {
      :id => conversations("ma_complain").id,
      :history => {
        :handle => "10",
        :department_id => departments(:劳动局).id,
        :user_id => users(:aaron).id
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
      get 'new', :id => conversations("ma_complain").id
      response.should be_success
    end
  end

  describe "save dispatch" do
    it "require handle" do
      @valid_attributes[:history].merge!(:handle => "")
      post :create, @valid_attributes
      assigns[:history].errors.on(:handle).should_not be_nil
    end

    it "require department and user if handle is turn" do
      @valid_attributes[:history].merge!(:department_id => "")
      post :create, @valid_attributes
      assigns[:history].errors.on(:department_id).should_not be_nil
    end

    it "require department and user if handle is apply" do
      @valid_attributes[:history].merge!(:handle => "30", :department_id => "")
      post :create, @valid_attributes
      assigns[:history].errors.on(:department_id).should_not be_nil
    end

    it "require user if handle is turn" do
      @valid_attributes[:history].merge!(:user_id => "")
      post :create, @valid_attributes
      assigns[:history].errors.on(:user_id).should_not be_nil
    end

    it "require user if handle is apply" do
      @valid_attributes[:history].merge!(:handle => "30", :user_id => "")
      post :create, @valid_attributes
      assigns[:history].errors.on(:user_id).should_not be_nil
    end


    #保存
    it "should be save" do
      lambda do
        post :create, @valid_attributes
        conversations(:ma_complain).reload.state.should == 10
      end.should change(History, :count).by(1)
    end

    it "should send a message" do
      lambda do
        post :create, @valid_attributes
      end.should change(Message, :count).by(1)
    end


    #转办
    it "should be turn" do
      lambda do
        post :create, @valid_attributes
        conversations(:ma_complain).reload.state.should == 10
      end.should change(Workitem, :count).by(1)
    end

    #自己办理
    it "should deal by himself" do
      lambda do
        post :create, @valid_attributes.merge(:history => {:handle => 20})
        conversations(:ma_complain).reload.state.should == 20
      end.should change(Workitem, :count).by(1)
    end

    #直接办结
    it "should be finish" do
      lambda do
        post :create, @valid_attributes.merge(:history => {:handle => 90})
        conversations(:ma_complain).reload.state.should == 90
      end.should_not change(Workitem, :count)
    end
  end
end
