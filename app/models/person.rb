class Person < ActiveRecord::Base
  has_many :events
  has_many :cases, :through => :event
  #创建人,修改人
  belongs_to :creator, :class_name => "User"
  belongs_to :modifier, :class_name => "User"

  validates_presence_of :phone, :name
  validates_length_of :phone, :name, :cardno, :mobile, :maximum => 20, :allow_nil => true
  validates_length_of :address, :jobunit, :email, :maximum => 50, :allow_nil => true
end
