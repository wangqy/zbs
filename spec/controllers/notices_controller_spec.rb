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
  
  it 'should view notices' do
    n = notices(:公告1)
    get :show, :id => n
    response.should be_success
  end
  
  it 'should create notice' do
    lambda do
      create_notice
      flash[:notice].should have_text('新增公告成功')
      response.should be_redirect
    end.should change(Notice, :count).by(1)
  end

  it 'should modify notice' do
    lambda do
      n = notices(:公告1)
      post :update, :notice => {:title => '公告标题A'}, :id => n
      flash[:notice].should have_text('更新公告成功')
      assigns[:notice].title.should == '公告标题A'
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

  def create_notice
    post :create, :notice => {:title => '公告标题3',
                              :content => '公告内容3'}
  end
end
