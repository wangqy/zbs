假如 /有以下(.+)事项:/ do |state_label, hashes|
  state = 10
  case state_label
  when "已受理"
    state = 20
  when "待审核"
    state = 30
  when "已退回"
    state = 40
  when "待重办"
    state = 50
  end
  events = hashes.arguments_replaced({"事件编号"=>"calltag","事件主题"=>"title","登记时间"=>"created_at","登记人"=>"creator"}).hashes
  events.each do |event|
    event = Event.find_by_calltag(event["calltag"])
    event.update_attribute(:state, state)
  end
end
