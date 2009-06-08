class DispatchesController < ApplicationController
  def index
    @list = Conversation.paginate :conditions => ["state = ?", 0], :page => params[:page], :order => 'id desc'
  end

  def new
    @conversation = Conversation.find(params[:id])
    #避免view调用params[:history][:timeout]报错
    params[:history] = {}
  end

  #开启流程
  def create
    @history = History.new(params[:history])
    @history.creator = current_user
    @conversation = Conversation.find(params[:id])
    if @history.valid?
      @history.conversation = @conversation
      Conversation.transaction do
        #状态
        @conversation.set_next_state_from @history.handle
        @conversation.histories << @history
        last_workitem = nil

        workitem_attributes = workitem_attributes_from(@history, last_workitem)
        #非"直接办结","确认办结"
        if workitem_attributes
          workitem_attributes[:last_store_id] = current_user.id
          workitem_attributes[:creator] = current_user
          workitem = Workitem.new(workitem_attributes)
          @conversation.workitems << workitem
          #发送短信(分派时只有转办才发送短信)
          Message.create!(:conversation => @conversation, :user => workitem.store, :creator => current_user) if @history.is_need_msg?
        end
        @conversation.save! 
      end
      flash[:notice] = "办理成功."
      redirect_to dispatches_path
    else
      render :action => "new"
    end
  end

end
