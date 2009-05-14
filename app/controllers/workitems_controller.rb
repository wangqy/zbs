class WorkitemsController < ApplicationController
  def index
    @list = Workitem.of current_user
    @list.collect! do |w| 
      conversation = w.conversation
      conversation.workitem_id = w.id
      conversation
    end
  end

  def edit
    @workitem = Workitem.find(params[:id])
    @conversation = @workitem.conversation
    @list = @conversation.histories
    @history = @list.last
    #避免view调用params[:history][:timeout]报错
    params[:history] = {}
  end

  def update
    @workitem = Workitem.find(params[:id])
    @conversation = @workitem.conversation
    @history = History.new(params[:history])
    @history.creator = current_user
    if @history.valid?
      @history.conversation = @conversation
      Conversation.transaction do
        #状态
        @conversation.set_next_state_from @history.handle
        @conversation.histories << @history
        last_workitem = @workitem

        workitem_attributes = workitem_attributes_from(@history, last_workitem)
        if workitem_attributes
          workitem_attributes[:last_store_id] = last_workitem.store_id if last_workitem
          workitem_attributes[:creator] = current_user
          workitem = Workitem.new(workitem_attributes)
          @conversation.workitems << workitem
          #发送短信(只有转办,申请办结,退回,退回重办才发送短信)
          Message.create!(:conversation => @conversation, :user => workitem.store, :creator => current_user) if @history.is_need_msg?
        end
        @workitem.destroy
        @conversation.save! 
      end
      flash[:notice] = "待办事项处理成功"
      redirect_to :action => :index
    else
      @list = @conversation.histories
      render :action => "edit"
    end
  end

end
