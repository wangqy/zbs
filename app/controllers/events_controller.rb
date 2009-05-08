class EventsController < ApplicationController
  def new
    @conversation = Conversation.find(params[:event][:conversation_id])
    @list = @conversation.events
    @event = Event.new(params[:event])
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
    people = @conversation.people.select do |person|
      params[:phone].match(person.phone) || params[:phone].match(person.mobile)
    end
    @event.person_id = (people.size>0 ? people[0].id : 0)
  end

  def create
    @event = Event.new(params[:event])
    @event.creator = current_user
    @event.modifier = current_user
    #值班室信息
    @duty = Duty.new(params[:duty])
    @event.duty = @duty

    if @event.valid?
      Event.transaction do
        #追加联系电话
        unless @event.person.phone =~ %r(params[:phone])
          @event.person.phone += " #{params[:phone]}"
          @event.person.save
        end
        @event.save
      end
      flash.now[:notice] = '保存成功.'
    end

    @conversation = Conversation.find(params[:event][:conversation_id])
    @list = @conversation.events
    render :action => "new"  
  end

  def update
    @event = Event.find(params[:id])
    @event.modifier = current_user
    #值班室信息
    @duty = @event.duty
    @duty.update_attributes(params[:duty])

    if @event.update_attributes(params[:event])
      flash.now[:notice] = '保存成功.'
    end

    @conversation = Conversation.find(params[:event][:conversation_id])
    @list = @conversation.events
    render :action => "new"  
  end
  
  private
  def set_menu
    @menu = 'conversations'
  end
end
