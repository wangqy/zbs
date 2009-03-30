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
    if @event.update_attributes!(:state => 1)
      flash[:notice] = "办理成功."
      #start workflow
      li = OpenWFE::LaunchItem.new PDEF
      li.event_id = @event.id
      li.handle = params[:handle].to_i
      li.department_code = params[:department_code]
      li.user_login = current_user.login
      fei = ruote_engine.launch li
      history_log '添加流程', :fei => fei
      redirect_to dispatches_path
    else
      render :action => "new"
    end
  end

end
