class History < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :department
  belongs_to :user
  #创建人
  belongs_to :creator, :class_name => "User"

  validates_presence_of :handle, :creator
  validates_presence_of :department_id, :if => Proc.new {|h| [10,30].include?h.handle}
  validates_presence_of :user_id, :if => Proc.new {|h| [10,30].include?h.handle}

end
