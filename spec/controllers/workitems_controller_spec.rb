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
      get 'edit', :id => workitems("complain_workitem22").id
      assigns[:workitem].should_not be_nil
      assigns[:conversation].should_not be_nil
      assigns[:history].should_not be_nil
      response.should be_success
    end
  end

  describe "POST 'update'" do
    it "require handle" do
      @valid_attributes[:history].merge!(:handle => "")
      put :update, @valid_attributes
      assigns[:history].errors.on(:handle).should_not be_nil
    end

    it "require department if handle is turn" do
      @valid_attributes[:history].merge!(:department_id => "")
      put :update, @valid_attributes
      assigns[:history].errors.on(:department_id).should_not be_nil
    end

    it "should send a message" do
      lambda do 
        @valid_attributes[:history].merge!(:department_id => departments(:劳动局).id, :user_id => users(:aaron).id)
        put :update, @valid_attributes
      end.should change(Message, :count).by(1)
    end

    it "should not send a message" do
      lambda do 
        put 'update', @valid_attributes.merge(
          :history => {:handle => 21, :department_id => "", :user_id => ""}
        )
      end.should_not change(Message, :count)
    end

    #待受理
    describe "in prepare deal" do
      before(:each) do
        conversations(:ma_complain).update_attribute(:state, 10)
      end
      
      it "should delete last workitem and create a new workitem" do
        lambda do
          put 'update', @valid_attributes.merge(
            :history => {:handle => 10, :department_id => departments(:劳动局), :user_id => users(:aaron).id}
          )
          response.should redirect_to(workitems_path)
        end.should_not change(Workitem, :count)
      end

      #转办
      it "should be turn" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 10, :department_id => departments(:劳动局), :user_id => users(:aaron).id}
        )
        conversations(:ma_complain).reload.state.should == 10
      end

      #受理
      it "should be deal" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 21, :department_id => ""}
        )
        conversations(:ma_complain).reload.state.should == 20
      end

      #申请办结
      it "should be apply finish" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 30, :department_id => departments(:劳动局), :user_id => users(:aaron).id}
        )
        conversations(:ma_complain).reload.state.should == 30
      end

      #退回
      it "should be return" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 40}
        )
        conversations(:ma_complain).workitems.first.store.should == users(:quentin)
        conversations(:ma_complain).reload.state.should == 40
      end
    end

    describe "in deal" do
      before(:each) do
        conversations(:ma_complain).update_attribute(:state, 20)
      end

      #转办
      it "should be turn" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 10, :department_id => departments(:劳动局), :user_id => users(:aaron).id}
        )
        conversations(:ma_complain).reload.state.should == 10
      end

      #申请办结
      it "should be apply finish" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 30, :department_id => departments(:劳动局), :user_id => users(:aaron).id}
        )
        conversations(:ma_complain).reload.state.should == 30
      end
    end

    #已退回
    describe "in return" do
      before(:each) do
        conversations(:ma_complain).update_attribute(:state, 40)
      end

      #转办
      it "should be turn" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 10, :department_id => departments(:劳动局), :user_id => users(:aaron).id}
        )
        conversations(:ma_complain).reload.state.should == 10
      end

      #受理
      it "should be deal" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 21}
        )
        conversations(:ma_complain).reload.state.should == 20
      end
    end

    #待重办
    describe "in redeal" do
      before(:each) do
        conversations(:ma_complain).update_attribute(:state, 50)
      end

      #转办
      it "should be turn" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 10, :department_id => departments(:劳动局), :user_id => users(:aaron).id}
        )
        conversations(:ma_complain).reload.state.should == 10
      end

      #受理
      it "should be turn" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 21}
        )
        conversations(:ma_complain).reload.state.should == 20
      end

      #申请办结
      it "should be turn" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 30, :department_id => departments(:劳动局), :user_id => users(:aaron).id}
        )
        conversations(:ma_complain).reload.state.should == 30
      end
    end
    
    #待审核
    describe "in audit" do
      before(:each) do
        conversations(:ma_complain).update_attribute(:state, 30)
      end

      #确认办结
      it "should be turn" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 91}
        )
        conversations(:ma_complain).reload.state.should == 90
      end

      #退回重办
      it "should be redeal" do
        put 'update', @valid_attributes.merge(
          :history => {:handle => 41}
        )
        conversations(:ma_complain).workitems.first.store.should == users(:quentin)
        conversations(:ma_complain).reload.state.should == 50
      end
    end

  end
end
