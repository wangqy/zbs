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
    Event.transaction do
      @event.update_attributes!(:state => 1)
      #start workflow
      li = OpenWFE::LaunchItem.new PDEF
      li.event_id = @event.id
      li.handle = params[:handle].to_i
      li.user_login = params[:user_login]
      fei = ruote_engine.launch li
      history_log '添加流程', :fei => fei
    end
    flash[:notice] = "办理成功."
    redirect_to dispatches_path
  end

end
