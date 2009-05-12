class DispatchesController < ApplicationController
  def index
    @list = Conversation.paginate :conditions => ["state = ?", "0"], :page => params[:page], :order => 'id desc'
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
        if workitem_attributes
          workitem_attributes[:last_store_id] = last_workitem.store_id if last_workitem
          workitem_attributes[:creator] = current_user.login
          @conversation.workitems.create workitem_attributes
        end
        @conversation.save! 
      end
      flash[:notice] = "办理成功."
      #发送短信
      Message.create(:conversation => @conversation, :user => @history.user, :creator => current_user) unless @history.user.nil?
      redirect_to dispatches_path
    else
      render :action => "new"
    end
  end

end
