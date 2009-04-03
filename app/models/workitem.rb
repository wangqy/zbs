class Workitem < ActiveRecord::Base
  belongs_to :event

  named_scope :of, lambda{|user|
    {:conditions => ['store_name = ?', user.login]}
  }

  named_scope :belong, lambda{|department|
    {:conditions => ['store_name = ?', department.id]}
  }
end
