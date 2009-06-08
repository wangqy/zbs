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

  it 'should goto new' do
    get :new
    response.should be_success
  end

  it 'allows signup' do
    lambda do
      create_user
      assigns[:user].errors.should be_empty
      response.should be_redirect
    end.should change(User, :count).by(1)
  end

  it 'should goto new after create' do
    lambda do
      post :create, :user => { 
        :login => 'quire', 
        :email => 'quire@example.com',
        :realname => 'quire',
        :telephone => '26741022',
        :mobile => '1398888999',
        :password => 'quire',
        :disabled => '0',
        :department_id => '0'
      }, :commit => '保存,继续新增'
      assigns[:user].errors.should be_empty
      response.should redirect_to(:controller => 'users', :action => 'new')
    end.should change(User, :count).by(1)
  end

  it 'should create fails with invalid parameters' do
    lambda do
      create_user :login => ''
      assigns[:user].errors.on(:login).should_not be_empty
      response.should render_template('users/new')
    end.should change(User, :count).by(0)
  end

  it 'requires login on signup' do
    lambda do
      create_user(:login => nil)
      assigns[:user].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(User, :count)
  end

  it 'should goto pass' do
    get :pass
    response.should be_success
  end
  
  it 'allows modify password' do
    modify_password
    flash[:notice].should have_text('修改用户密码成功')
    assigns[:user].errors.should be_empty
    User.authenticate('cogentsoft','111111').should == users(:cogentsoft)
    response.should be_success
  end

  #修改坐席号
  it 'allows modify site' do
    xhr :post, :updatesite, :user => { :site => '802' }
    flash[:notice].should have_text('修改用户坐席号成功')
    assigns[:user].errors.should be_empty
    response.should render_template('_update_success')
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

  it "should get department's user" do
    get :dept, :id => departments(:劳动局).id
    response.should render_template('_dept_user')
    response.should be_success
    assigns(:list).should_not be_nil
  end

  it 'should goto edit' do
    user = users(:disable)
    get :edit, :id => user
    response.should be_success
  end

  it 'should update user' do
    user = users(:disable)
    post :update, :user => {:realname => '禁用名字'}, :id => user
    response.should redirect_to(:controller => 'users', :action => 'index')
    assigns("user").realname.should == '禁用名字'
  end

  it 'should update fails with invalid parameters' do
    user = users(:disable)
    post :update, :user => {:login=> ''}, :id => user
    assigns("user").errors.on(:login).should_not be_nil
    response.should render_template('users/new')
  end

  def create_user(options = {})
    post :create, :user => { 
      :login => 'quire', 
      :email => 'quire@example.com',
      :realname => 'quire',
      :telephone => '26741022',
      :mobile => '13988889999',
      :password => 'quire',
      :disabled => '0',
      :department_id => '0'
    }.merge(options)
  end

  def modify_password
    post :updatepass, :user=>{
      :password => '111111'
    }
  end

end
