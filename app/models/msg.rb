class Msg < ActiveRecord::Base
  establish_connection :sms
  set_table_name :tbl_SMSendTask
  set_primary_key :ID

  #短信模板配置
  DISPATCH_TEMPLATE = <<-EOF
    <%= DateTime.now.to_s(:db) %> 分派员刚将事件(主题:<%= title %>)转给你,请及时处理
  EOF

  #待办事项短信模板
  WORKITEM_TEMPLATE = <<-EOF 
    您的待办事项还有<%= sum %>个事件未处理,请尽快处理.
  EOF


  def initialize(params = nil)
    params ||= {}
    params.merge!(
      #信息机号码
      :OrgAddr => '1065730102418',
      #短信机系统标识
      :ServiceID => 'MGD4819901',
      :SMType => 0,
      :SendTime => DateTime.now,
      :NeedStateReport => 0,
      :FeeType => '01',
      :FeeCode => '0',
      :SmSendedNum => 0,
      :OperationType => 'WAS',
      :MessageID => '0',
      :DestAddrType => 0,
      :SubTime => DateTime.now,
      :TaskStatus => 0,
      :SendLevel => 1,
      :SendState => 0,
      :TryTimes => 3,
      :Count => 1,
      :SendType => 1
    )
    super
  end

  def self.send_to(mobile, content, creator_id = 0)
    self.create(
      :DestAddr => mobile,
      :SM_Content => content,
      :CreatorID => creator_id
    )
  end
end
