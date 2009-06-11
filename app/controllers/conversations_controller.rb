class ConversationsController < ApplicationController
  def index
    @list = []
    unless params[:phone].blank?
      @list = Conversation.search(params[:phone])
    end
  end

  def list
    @menu = 'searches'
    @list = Conversation.search(params[:phone])
  end

  def show
    @menu = 'searches'
    @conversation = Conversation.find(params[:id])
  end

  def new
    @conversation = Conversation.new
    @event = Event.new
    @person = Person.new
    @duty = Duty.new
    @event.timing = DateTime.now.to_s(:with_year)
    @event.category = params[:category]
    @event.record_id = params[:record_id]
    @person.phone = params[:phone]
    #值班室信息
    @duty.watchman = current_user.realname
    @duty.receiver = current_user.realname
    @duty.manager = current_user.department.manager
    #类型默认为来电
    @event.category = 1
  end

  def create
    @conversation = Conversation.new(params[:conversation])
    @event = Event.new(params[:event])
    @person = Person.new(params[:person])
    @duty = Duty.new(params[:duty])
    @event.duty = @duty
    @event.person = @person
    @conversation.events << @event
    [@conversation, @event, @person].each do |c|
      c.creator = current_user
      c.modifier = current_user
    end
    unless [@conversation, @event, @person, @duty].map(&:valid?).include?(false)
      Conversation.transaction do
        @conversation.save!
        @person.save!
        @event.save!
        @duty.save!
      end
    end
    unless [@conversation, @event, @person, @duty].map(&:errors).map(&:empty?).include?(false)
      flash[:notice] = "保存成功!"
      redirect_to :phone => params[:phone]
    else
      render :action => "new"
    end
  end
end
