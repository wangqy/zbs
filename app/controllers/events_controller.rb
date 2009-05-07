class EventsController < ApplicationController
  def new
    @conversation = Conversation.find(params[:conversation_id])
    @list = @conversation.events
    @event = Event.new
    @event.wavfile = params[:recordfile] if params[:recordfile]
    @event.timing = DateTime.now.to_s(:with_year)
    #值班室信息
    @duty = Duty.new
    @duty.watchman = current_user.realname
    @duty.receiver = current_user.realname
    @duty.manager = current_user.department.manager
    #事件类型默认来电
    @event.category = 1
    #找出默认的联系人
    people = @conversation.people.select {|p| [p.mobile, p.phone].include? params[:phone]}
    @event.person_id = (people.size>0 ? people[0].id : 0)
  end

  def create
    @conversation = Conversation.find(params[:conversation][:id])
    @list = @conversation.events
    @event = Event.new(params[:event])
    @event.creator = current_user
    @event.modifier = current_user

    if @event.valid?
      Event.transaction do
        #追加联系电话
        unless @event.person.phone =~ %r(params[:phone])
          @event.person.phone += " #{params[:phone]}"
          @event.person.save
        end
        @event.save
      end
      flash[:notice] = '保存成功.'
    end
    render :action => "new"  
  end
end
