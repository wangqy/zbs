require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe DepartmentsController do
  fixtures :departments

  before(:each) do
    login_as :cogentsoft
  end

  it "should get new page" do
    get :new
    response.should be_success
  end

  it "should get new child page" do
    xhr :get, :new, :department_id => departments(:教育局).id
    response.should be_success
  end

  it "should save" do
    lambda do
      create_department
      response.should be_success
    end.should change(Department, :count).by(1)
  end

  it "require name" do
    lambda do
      create_department :name => ''
      assigns("department").errors.on(:name).should_not be_nil
    end.should change(Department, :count).by(0)
  end

  it "should get edit page" do
    d = departments(:劳动局)
    get :edit, :id => d
    assigns("department").name.should == "劳动局"
    response.should be_success
  end

  it "should edit" do
    lambda do
      d = departments(:劳动局)
      post :update, :department => {:name => "发改局"}, :id => d.id
      assigns[:department].name.should == "发改局"
    end.should change(Department, :count).by(0)
  end

  it "should delete" do
    delete :destroy, :id => departments(:劳动局)
    response.should be_redirect
    flash[:notice].should have_text('删除机构成功')
  end
  
  #创建一个机构
  def create_department(options={})
    post :create, :department => {:name => "发改局", :manager => "发改局长"}.merge(options)
  end
end
