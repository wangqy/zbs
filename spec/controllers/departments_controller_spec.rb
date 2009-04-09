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
    lambda do
      create_department
      response.should be_redirect
    end.should change(Department, :count).by(1)
  end

  it "更新机构" do
    lambda do
      d = departments(:劳动局)
      post :update, :department => {:name => "发改局"}, :id => d.id
      #assigns["department"]/assigns[:department]/assigns("department")/assigns(:department)
      assigns[:department].name.should == "发改局"
      assigns["department"].name.should == "发改局"
      assigns(:department).name.should == "发改局"
      assigns("department").name.should == "发改局"
      #p assigns[:department].modifier.realname
    end.should change(Department, :count).by(0)
  end

  it "删除机构" do
    d = departments(:劳动局)
    d.should_not be_nil
    delete :destroy, :id => d
    response.should be_redirect
    flash[:notice].should have_text('删除成功')
  end

  #创建一个机构
  def create_department(options={})
    post :create, :department => {:code => "T001", :name => "发改局", :manager => "发改局长"}.merge(options)
  end
end
