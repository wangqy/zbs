class Record < ActiveRecord::Base
  has_one :event
  validates_uniqueness_of :uniqueid
end
