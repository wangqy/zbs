require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe UsersController do
  fixtures :users

  before(:each) do
    login_as :cogentsoft
  end

  it 'allows signup' do
    lambda do
      create_user
      response.should be_redirect
    end.should change(User, :count).by(1)
  end

  it 'requires login on signup' do
    lambda do
      create_user(:login => nil)
      assigns[:user].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(User, :count)
  end
  
  it 'allows modify password' do
    modify_password
    flash[:notice].should have_text('密码修改成功')
    response.should be_success
  end

  it 'allows disable user' do
    user = users(:aaron)
    user.disabled.should == 0
    get :disable, :id => user.id
    response.should be_redirect
    flash[:notice].should have_text('禁用用户成功')
    assigns(:user).disabled.should == 1
  end
  
  it 'allows enable user' do
    user = users(:disable)
    user.disabled.should == 1 
    get :enable, :id => user.id
    response.should be_redirect
    flash[:notice].should have_text('启用用户成功')
    assigns(:user).disabled.should == 0
  end

  def create_user(options = {})
    post :create, :user => { 
      :login => 'quire', 
      :email => 'quire@example.com',
      :realname => 'quire',
      :telephone => '26741022',
      :password => 'quire',
      :disabled => '0'
    }.merge(options)
  end

  def modify_password
    post :updatepass, :user=>{
      :password => '111111'
    }
  end

end
