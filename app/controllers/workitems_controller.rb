class WorkitemsController < ApplicationController
  def index
  end

  def edit
  end

  def update
    flash[:notice] = "待办事项处理成功"
    redirect_to :action => :index
  end

end
