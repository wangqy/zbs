class WorkitemsController < ApplicationController
  def index
    @list = Workitem.of current_user
    @list.concat Workitem.belong(current_user.department) if current_user.department
    @list.collect! do |w| 
      event = w.event
      event.workitem_id = w.id
      event
    end
  end

  def edit
    @workitem = Workitem.find(params[:id])
    #FIX aim_enum方法无法找到?
    @event = Event.find(@workitem.event)
    @list = @event.historys
    #避免view调用params[:history][:timeout]报错
    params[:history] = {}
  end

  def update
    @workitem = Workitem.find(params[:id])
    @event = Event.find(@workitem.event)
    @history = History.new(params[:history])
    @history.creator = current_user
    if @history.valid?
      @history.event = @event
      Event.transaction do
        #状态
        @event.set_next_state_from @history.handle
        @event.historys << @history
        last_workitem = @workitem

        workitem_attributes = workitem_attributes_from(@history, last_workitem)
        if workitem_attributes
          workitem_attributes[:last_store_name] = last_workitem.store_name if last_workitem
          workitem_attributes[:creator] = current_user.login
          @event.workitems.create workitem_attributes
        end
        @workitem.destroy
        @event.save! 
      end
      flash[:notice] = "待办事项处理成功"
      redirect_to :action => :index
    else
      @list = @event.historys
      render :action => "edit"
    end
  end

end
