class Msg < ActiveRecord::Base
  establish_connection :sms
  set_table_name :tbl_SMSendTask
  set_primary_key :ID

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
end
