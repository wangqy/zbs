class WorkitemsController < ApplicationController
  def index
    opts = { :order => 'dispatch_time DESC' }
    opts[:conditions] = { :store_name => current_user.login } 

    @list = OpenWFE::Extras::ArWorkitem.paginate_by_params(
      [   
        # parameter_name[, column_name]
        'wfid',
        [ 'workflow', 'wf_name' ],
        [ 'store', 'store_name' ],
        [ 'participant', 'participant_name' ]
      ],  
      params,
      opts
    )

    @list = @list.map do |workitem|
      event = Event.find(workitem.field("event_id"))
      event.workitem_id = workitem.id
      event
    end
  end

  def edit
    workitem = OpenWFE::Extras::ArWorkitem.find(params[:id])
    @event = Event.find(workitem.field("event_id"))
    @event.workitem_id = workitem.id
  end

  def update
    workitem = OpenWFE::Extras::ArWorkitem.find(params[:id])
    origin_workitem = workitem.to_owfe_workitem 
    OpenWFE::Extras::ArWorkitem.destroy(workitem.id) 
    RuotePlugin.ruote_engine.reply(origin_workitem)
    history_log('proceeded', :fei => origin_workitem.fei) 
    flash[:notice] = "待办事项处理成功"
    redirect_to :action => :index
  end

end
