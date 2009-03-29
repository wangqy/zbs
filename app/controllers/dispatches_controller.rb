class DispatchesController < ApplicationController
  def index
    @list = Event.paginate :conditions => ["state = ?", "0"], :page => params[:page]
  end

  def new
    @event = Event.find(params[:id])
  end

  #开启流程
  def create
    @event = Event.find(params[:id])
    #TODO make business and workflow operation in the same transaction
    if @event.update_attribute(:state, 1)
      #start workflow
      li = OpenWFE::LaunchItem.new @@pdef
      li.event_id = @event.id
      li.handle = params[:handle]
      li.user_login = params[:user_login]
      fei = ruote_engine.launch li
      history_log '添加流程', :fei => fei
      flash[:notice] = "办理成功."
      redirect_to dispatches_path
    else
      render :new
    end
  end

end
