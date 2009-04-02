class DispatchesController < ApplicationController
  def index
    @list = Event.paginate :conditions => ["state = ?", "0"], :page => params[:page]
  end

  def new
    @event = Event.find(params[:id])
  end

  #开启流程
  def create
    @history = History.new(params[:history])
    if @history.valid?
      @event = Event.find(params[:id])
      @history.event = @event
      Event.transaction do
        #状态
        @event.set_next_state_from @history.handle
        @event.historys << @history
        last_workitem = nil

        workitem_attributes = workitem_attributes_from(@history, last_workitem)
        if workitem_attributes
          workitem_attributes[:last_store_name] = last_workitem.store_name if last_workitem
          workitem_attributes[:creator] = current_user.login
          @event.workitems.create workitem_attributes
        end
        @event.save! 
      end
      flash[:notice] = "办理成功."
      redirect_to dispatches_path
    else
      render :action => "new"
    end
  end

end
