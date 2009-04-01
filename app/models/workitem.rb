class Workitem < ActiveRecord::Base
  belongs_to :event

  named_scope :of, lambda{|user|
    {:conditions => ['store_name = ?', user.login]}
  }
end
