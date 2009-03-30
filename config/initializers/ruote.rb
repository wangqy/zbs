#workflow definition
PDEF = OpenWFE.process_definition :name => 'dispatch_event' do
  sequence do
    participant :ref => "${f:user_login}", :if => "${f:handle} == 1"
    #转办,自己受理,直接办结
    turn :if => "${f:handle} == 1"
    get :if => "${f:handle} == 2"
    finish
  end
end

begin
  ActionController::Base.ruote_engine.register_participant :turn, OpenWFE::Extras::ArParticipant

  ActionController::Base.ruote_engine.register_participant :get, OpenWFE::Extras::ArParticipant

  ActionController::Base.ruote_engine.register_participant :finish do |workitem|
    puts "finish event #{workitem.event_id}"
  end
rescue
end

