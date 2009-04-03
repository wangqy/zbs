class History < ActiveRecord::Base
  belongs_to :event
  belongs_to :department
  #创建人
  belongs_to :creator, :class_name => "User", :foreign_key => "creator"

  validates_presence_of :handle, :creator
  validates_presence_of :department_id, :if => Proc.new {|h| [10,30].include?h.handle}

end
