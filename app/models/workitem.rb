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

  named_scope :users, lambda{
    {
      :select => 'store_id,count(store_id) as sum',
      :group => 'store_id'
    }
  }

  def self.send_msg
    self.users.each do |w|
      sum = w.sum
      content = ERB.new(Msg::WORKITEM_TEMPLATE).result(binding)
      Msg.send_to(w.store.mobile, content)
    end
  end
end
