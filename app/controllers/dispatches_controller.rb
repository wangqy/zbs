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
      redirect_to dispatches_path
    else
      render :action => "new"
    end
  end

end
