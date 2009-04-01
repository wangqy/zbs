require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Employee do
  before(:each) do
    @valid_attributes = {
      :name => "张三",
      :sex => 1,
      :department_id => 1,
      :position => "科员",
      :telephone => "26741111",
      :mobile => "13611111111",
      :ismanager => 1,
      :email => "zhangsan@zhangsan.com",
      :remark => "备注"
    }
  end

  it "should create a new instance given valid attributes" do
    Employee.create!(@valid_attributes)
  end
end
