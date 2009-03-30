#workflow definition
PDEF = OpenWFE.process_definition :name => 'dispatch_event' do
  sequence do
    cursor :break_if => "(${f:handle} == 90) || (${f:handle} == 91)" do
      participant :ref => "${f:department_code}", :if => "${f:handle} == 10 || ${f:handle} == 30"
      participant :ref => "${f:user_login}", :if => "(${f:handle} == 20) || (${f:handle} == 21)"
    end
    finish
  end
end

begin
  ActionController::Base.ruote_engine.register_participant :finish do |workitem|
    puts "finish event #{workitem.event_id}"
  end
rescue
end

