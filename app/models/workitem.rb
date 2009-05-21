class Workitem < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :store, :class_name => "User"
  belongs_to :last_store, :class_name => "User"
  belongs_to :creator, :class_name => "User"
  
  #任务预警时间
  WARNING_DAYS = 3

  named_scope :of, lambda{|user|
    {
      :conditions => ['store_id = ?', user.id],
      :order => 'created_at'
    }
  }

  #所有存在未完成任务的用户
  named_scope :users, lambda{
    {
      :select => 'store_id,count(store_id) as sum',
      :group => 'store_id'
    }
  }

  #存在预警状态任务的用户
  named_scope :warning, lambda{
    { :conditions => ['created_at <= ?', WARNING_DAYS.days.ago] }
  }


  def self.send_msg
    warning_users = self.warning.users
    self.users.each do |w|
      warning_workitem = warning_users.select{|wu| wu.store_id == w.store_id}
      warning_sum = warning_workitem ? warning_workitem.first.sum : 0
      sum = w.sum
      content = ERB.new(Msg::WORKITEM_TEMPLATE).result(binding)
      begin
        Msg.send_to(w.store.mobile, content)
      rescue
        logger.error "#{$!}.send message(#{w.store.realname}) error:#{content}"
      end
    end
  end
end
