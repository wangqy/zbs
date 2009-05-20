class Department < ActiveRecord::Base
  #负责人
  has_many :managers, :class_name => "User", :foreign_key => "department_id"
  #创建人
  belongs_to :creator, :class_name => "User"
  #最后修改人
  belongs_to :modifier, :class_name => "User"
  #子机构
  has_many :children, :class_name => "Department", :foreign_key => "parent_id"
  #上级机构
  belongs_to :parent, :class_name => "Department", :foreign_key => "parent_id"

  validates_presence_of :name
  validates_length_of :name, :maximum => 10
  validates_length_of :manager, :maximum => 10, :allow_nil => true
  validates_length_of :telephone, :fax, :maximum => 20, :allow_nil => true
  validates_length_of :remark, :maximum => 800, :allow_nil => true

  named_scope :top, :conditions => ["parent_id is null"]
end
