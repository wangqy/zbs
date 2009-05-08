require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PeopleController do
  before(:each) do
    login_as :aaron
    @valid_attribute = {
      :person => {
        :name => '张先生',
        :phone => '26741022',
        :cardno => '441521198311110022',
        :mobile => '13988889999',
        :sex => 1,
        :email => 'mahb@cogentsoft.com.cn',
        :address => '深圳南山',
        :jobunit => '高正软件'
      }
    }
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  it "should be save" do
    lambda do
      post :create, @valid_attribute
      response.should be_success
    end.should change(Person, :count).by(1)
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id => people(:ma)
      response.should be_success
    end
  end

  it 'should be update' do
    @valid_attribute[:person].merge! :name => '马波波'
    post :update, @valid_attribute.merge!(:id => people(:ma).id)
    response.should be_success
    assigns("person").name.should == '马波波'
  end

end
