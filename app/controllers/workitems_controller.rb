class WorkitemsController < ApplicationController
  def index
    @list = Workitem.of current_user
    @list.collect! do |w| 
      event = w.event
      event.workitem_id = w.id
      event
    end
    #@list.concat Workitem.find_by_store_name(current_user.department.code)
  end

  def edit
    @workitem = Workitem.find(params[:id])
    #FIX aim_enum方法无法找到?
    @event = Event.find(@workitem.event)
  end

  def update
    @workitem = Workitem.find(params[:id])
    @event = Event.find(@workitem.event)
    @history = History.new(params[:history])
    if @history.valid?
      @history.event = @event
      Event.transaction do
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
      render :action => "edit"
    end
  end

end
