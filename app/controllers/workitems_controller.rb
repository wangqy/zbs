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
  end

end
