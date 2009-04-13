class LogsController < ApplicationController
  #列表
  def index
    @list = Log.paginate :page => params[:page], :order => "operatedate desc"
  end

  #查看
  def show
    @log = Log.find(params[:id])
  end
end
