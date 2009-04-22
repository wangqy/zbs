require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe DepartmentsController do
  fixtures :departments

  before(:each) do
    login_as :cogentsoft
  end

  it "查询机构" do
    get :index
    response.should be_success
  end

  it "查看机构" do
    d = departments(:劳动局)
    get :show, :id => d 
    response.should be_success
  end

  it "新增机构" do
    get :new
    response.should be_success
  end

  it "保存机构 - 返回列表" do
    lambda do
      create_department
      response.should be_redirect
    end.should change(Department, :count).by(1)
  end

  it "保存机构 - 继续新增" do
    lambda do
      post :create, :department => {:code => "T001", :name => "发改局", :manager => "发改局长"}, :commit => '保存,继续新增'
      response.should be_redirect
      response.should redirect_to(:controller => 'departments', :action => 'new')
    end.should change(Department, :count).by(1)
  end

  it "保存机构 - 名称不能为空" do
    lambda do
      #post :create, :department => {:code => "T001", :name => "", :manager => "发改局长"}
      create_department :name => ''
      assigns("department").errors.on(:name).should_not be_nil
    end.should change(Department, :count).by(0)
  end

  it "编辑机构" do
    d = departments(:劳动局)
    get :edit, :id => d
    assigns("department").name.should == "劳动局"
    response.should be_success
  end

  it "更新机构成功" do
    lambda do
      d = departments(:劳动局)
      post :update, :department => {:name => "发改局"}, :id => d.id
      #assigns["department"]/assigns[:department]/assigns("department")/assigns(:department)
      assigns[:department].name.should == "发改局"
      assigns["department"].name.should == "发改局"
      assigns(:department).name.should == "发改局"
      assigns("department").name.should == "发改局"
      response.should redirect_to(:controller => 'departments', :action => 'index')
      #p assigns[:department].modifier.realname
    end.should change(Department, :count).by(0)
  end
  
  it "更新机构失败" do
    d = departments(:劳动局)
    post :update,:department => {:name => ''}, :id => d.id
    assigns('department').errors.should_not be_empty
    response.should render_template("departments/new")
  end

  it "删除机构成功" do
    d = departments(:劳动局)
    d.should_not be_nil
    delete :destroy, :id => d
    response.should be_redirect
    flash[:notice].should have_text('删除机构成功')
  end
  
  it "删除机构失败" do
    delete :destroy, :id => 1000001
    response.should be_redirect
    flash[:notice].should have_text('删除机构失败')
  end

  #创建一个机构
  def create_department(options={})
    post :create, :department => {:code => "T001", :name => "发改局", :manager => "发改局长"}.merge(options)
  end
end
