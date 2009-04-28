class Message < ActiveRecord::Base
  belongs_to :case
  belongs_to :user
  #创建人
  belongs_to :creator, :class_name => "User"

  validates_presence_of :case_id, :user_id, :content

  TEMPLATE = <<-EOF
    <%= DateTime.now.to_s(:db) %> 分派员刚将事件转给你,请及时处理
  EOF

  before_validation do |message|
    #TODO 短信内容加上事件主题
    #title = message.case.title 
    message.content = ERB.new(TEMPLATE).result(binding)
  end

  def after_save
    Msg.create(
      :DestAddr => self.user.mobile,
      :SM_Content => self.content,
      :CreatorID => self.id
    )
  end

end
