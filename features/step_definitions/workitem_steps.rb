假如 /有以下待办事项:/ do |hashes|
  events = hashes.arguments_replaced({"事件编号"=>"calltag","事件主题"=>"title","登记时间"=>"created_at","登记人"=>"creator"}).hashes
  events.each do |event|
    event.merge!( 
      "created_at" => "2009-#{event[:created_at]}".to_datetime, 
      :timing => "2009-#{event[:created_at]}".to_datetime,
      :content => "测试内容", 
      :callnumber => 13988889999
    )
  end
  #events = Call.create!(events)
  events = Event.all

  events.each do |event|
    #start workflow
    li = OpenWFE::LaunchItem.new PDEF
    li.event_id = event.id
    li.handle = 1
    li.user_login = "aaron"
    fei = ActionController::Base.ruote_engine.launch li
    sleep 5
  end
end
