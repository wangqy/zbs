class Duty < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :watchman, :receiver, :manager
  validates_length_of :watchman, :receiver, :manager, :maximum => 10, :allow_nil => true
end
