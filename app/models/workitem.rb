class Workitem < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :store, :class_name => "User"
  belongs_to :last_store, :class_name => "User"
  
  named_scope :of, lambda{|user|
    {
      :conditions => ['store_id = ?', user.id],
      :order => 'id desc'
    }
  }
end
