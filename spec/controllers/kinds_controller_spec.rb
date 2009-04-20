require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KindsController do

  before(:each) do
    login_as :aaron
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      assigns[:parent_list].should_not be_nil
      response.should be_success
    end
  end

  describe "Save" do
    it "require name" do
      lambda do
        xhr :post, :create, :kind=>{
          :name => ""
        }
        assigns[:kind].errors.on(:name).should_not be_nil
      end.should_not change(Kind, :count)
    end

    it "should be successful" do
      lambda do
        xhr :post, :create, :kind=>{
          :name => "产权纠纷"
        }
        flash[:notice] = "新增事件分类成功"
      end.should change(Kind, :count).by(1)
    end
  end
end
