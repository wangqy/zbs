class Department < ActiveRecord::Base
  #负责人
  has_many :managers, :class_name => "User", :foreign_key => "department_id"
  #创建人
  belongs_to :creator, :class_name => "User"
  #最后修改人
  belongs_to :modifier, :class_name => "User"

  validates_presence_of :name, :code 
  validates_uniqueness_of :name, :code
  validates_length_of :code, :maximum => 10
  validates_length_of :name, :maximum => 10
  validates_length_of :manager, :maximum => 10, :allow_nil => true
  validates_length_of :telephone, :fax, :maximum => 20, :allow_nil => true
  validates_length_of :email, :address, :maximum => 120, :allow_nil => true
  validates_length_of :remark, :maximum => 800, :allow_nil => true
end
