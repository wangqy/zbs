class DispatchesController < ApplicationController
  def index
    @list = Event.paginate :page => params[:page]
  end

  def new
    @event = Event.find(params[:id])
  end

  #开启流程
  def create
  end

end
