class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  #创建人
  belongs_to :creator, :class_name => "User"

  named_scope :not_sended, :conditions => ['is_sended = ?', false]

  validates_presence_of :conversation_id, :user_id, :content

  before_validation do |message|
    title = message.conversation.title 
    creator = message.user.realname
    message.content = ERB.new(Msg::DISPATCH_TEMPLATE).result(binding)
  end

  def self.send_msg
    self.not_sended.each do |message|
      begin
        Msg.send_to(message.user.mobile, message.content, message.id.to_s)
        message.update_attribute :is_sended, true
      rescue
        logger.error "send message(#{message.id}) error:#{message.content}"
      end
    end
  end

end
