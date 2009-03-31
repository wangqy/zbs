class Department < ActiveRecord::Base

  #部门成员
  has_many :employees, :class_name => "Employee", :foreign_key => "department_id"
  #负责人
  has_many :managers, :class_name => "Employee", :foreign_key => "department_id"

  validates_presence_of :code, :name
  validates_length_of :code, :maximum => 10
  validates_length_of :name, :maximum => 10
  validates_length_of :manager, :maximum => 10, :allow_nil => true
  validates_length_of :telephone, :fax, :maximum => 20, :allow_nil => true
  validates_length_of :email, :address, :maximum => 120, :allow_nil => true
  validates_length_of :remark, :maximum => 800, :allow_nil => true
end
