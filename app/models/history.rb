class History < ActiveRecord::Base
  belongs_to :event

  validates_presence_of :handle  
end
