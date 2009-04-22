require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NoticesController do
  fixtures :notices

  before :each do
    login_as :cogentsoft
  end

  it 'should query notices' do
    get :index
    response.should be_success
  end

  it 'should goto list' do
    get :list
    response.should be_success
  end
  
  it 'should view notices' do
    n = notices(:公告1)
    get :show, :id => n
    response.should be_success
  end

  it "should goto new" do
    get :new
    response.should be_success
  end
  
  it 'should create notice - 保存,返回列表' do
    lambda do
      create_notice
      flash[:notice].should have_text('新增公告成功')
      response.should be_redirect
      response.should redirect_to(:controller => 'notices', :action => 'index')
    end.should change(Notice, :count).by(1)
  end

  it 'should create and deploy notice' do
    lambda do
      create_notice :deployed => 1
      flash[:notice].should have_text('新增公告成功')
      assigns("notice").deployed.should == 1
      response.should redirect_to(:controller => 'notices', :action => 'index')
    end.should change(Notice, :count).by(1)
  end

  it 'should create notice - 保存,继续新增' do
    lambda do
      post :create, :notice => {:title => '公告标题3',
                              :content => '公告内容3'}, :commit => '保存,继续新增'
      flash[:notice].should have_text('新增公告成功')
      response.should be_redirect
      response.should redirect_to(:controller => 'notices', :action => 'new')
    end.should change(Notice, :count).by(1)
  end

  it 'should create fails with invalid parameters' do
    lambda do
      post :create, :notice => {:title => '',
                              :content => '公告内容3'}
      response.should be_success
      assigns("notice").errors.on(:title).should_not be_nil
    end.should change(Notice, :count).by(0)
  end

  it 'should goto edit' do
    n = notices(:公告1)
    get :edit, :id => n
    assigns("notice").title.should == '公告标题1'
    response.should be_success
  end

  it 'should modify notice' do
    lambda do
      n = notices(:公告1)
      post :update, :notice => {:title => '公告标题A'}, :id => n
      flash[:notice].should have_text('更新公告成功')
      assigns[:notice].title.should == '公告标题A'
    end.should change(Notice, :count).by(0)
  end

  it 'should modify deploy status' do
    lambda do
      n = notices(:公告2)
      post :update, :notice => {:deployed => '1'}, :id => n
      flash[:notice].should have_text('更新公告成功')
      assigns[:notice].deployed.should == 1
    end.should change(Notice, :count).by(0)
  end

  it 'should modify fails with invalid parameters' do
    lambda do
      n = notices(:公告1)
      post :update, :notice => {:title => ''}, :id => n
      assigns[:notice].errors.on(:title).should_not be_nil
    end.should change(Notice, :count).by(0)
  end

  it 'should delete notice' do
    lambda do
      n = notices(:公告1)
      delete :destroy, :id => n
      flash[:notice].should have_text('删除公告成功')
      response.should be_redirect
    end.should change(Notice, :count).by(-1)
  end

  it "should delete fails with none exists id" do
    lambda do
      delete :destroy, :id => 100001
      flash[:notice].should have_text('删除公告失败')
      response.should redirect_to(:controller => 'notices', :action => 'index')
    end.should change(Notice, :count).by(0)
  end

  def create_notice(options={})
    post :create, :notice => {:title => '公告标题3',
                              :content => '公告内容3'}.merge(options)
  end
end
