class Person < ActiveRecord::Base
  has_many :events
  has_many :conversations, :through => :events
  #创建人,修改人
  belongs_to :creator, :class_name => "User"
  belongs_to :modifier, :class_name => "User"

  validates_presence_of :phone, :name
  #放置联系人的所有电话
  validates_length_of :phone, :maximum => 100, :allow_nil => true
  validates_length_of :name, :cardno, :mobile, :maximum => 20, :allow_nil => true
  validates_length_of :address, :jobunit, :email, :maximum => 50, :allow_nil => true
end
