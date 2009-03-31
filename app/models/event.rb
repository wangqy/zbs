class Event < ActiveRecord::Base
  belongs_to :case
  belongs_to :person

  attr_accessor :workitem_id
end
