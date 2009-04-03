class History < ActiveRecord::Base
  belongs_to :event

  validates_presence_of :handle  
  validates_presence_of :department_code, :if => Proc.new {|h| [10,30].include?h.handle}
end
