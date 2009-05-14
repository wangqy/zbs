class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  #创建人
  belongs_to :creator, :class_name => "User"

  validates_presence_of :conversation_id, :user_id, :content

  before_validation do |message|
    title = message.conversation.title 
    message.content = ERB.new(Msg::DISPATCH_TEMPLATE).result(binding)
  end

  def after_save
    Msg.send_to(self.user.mobile, self.content, self.id)
  end

end
