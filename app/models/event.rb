class Event < ActiveRecord::Base
  belongs_to :case
  belongs_to :person
  has_many :workitems
  has_many :historys

  #当前流程ID
  attr_accessor :workitem_id
end
