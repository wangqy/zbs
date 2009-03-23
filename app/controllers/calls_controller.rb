class CallsController < ApplicationController
  def index
  end

  def new
    @call = Call.new
  end

  def create
    @call = Call.new(params[:call])

    if @call.save
      flash[:notice] = '保存成功.'
      redirect_to edit_call_path(@call)
    else
      render :action => "new"  
    end
  end

  def edit
    @call = Call.find(params[:id])
    render :action => "new"
  end

  def update
    @call = Call.find(params[:id])
    if @call.update_attributes(params[:call])
      flash.now[:notice] = '更新成功.'
    end
    render :action => "new"
  end

end
