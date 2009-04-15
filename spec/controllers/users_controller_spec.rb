require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe UsersController do
  fixtures :users

  before(:each) do
    login_as :cogentsoft
  end

  it 'allows query users' do
    get :index
    response.should be_success
  end

  it 'allows signup' do
    lambda do
      create_user
      assigns[:user].errors.should be_empty
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

  it 'requires role' do
    lambda do
      create_user(:role => nil)
      assigns[:user].errors.on(:role).should_not be_nil
      response.should be_success
    end.should_not change(User, :count)
  end
  
  it 'allows modify password' do
    modify_password
    flash[:notice].should have_text('修改用户密码成功')
    assigns[:user].errors.should be_empty
    response.should render_template('users/_update_success')
    User.authenticate('cogentsoft','111111').should == users(:cogentsoft)
    response.should be_success
  end

  #修改坐席号
  it 'allows modify site' do
    xhr :post, :updatesite, :user => { :site => '802' }
    flash[:notice].should have_text('修改用户坐席号成功')
    assigns[:user].errors.should be_empty
    response.should render_template('users/_update_success')
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
      :disabled => '0',
      :department_id => '0',
      :role => 1
    }.merge(options)
  end

  def modify_password
    xhr :post, :updatepass, :user=>{
      :password => '111111'
    }
  end

end
