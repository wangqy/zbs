class CallsController < ApplicationController
  def index
    @list = Call.paginate :page => params[:page], :order => 'created_at DESC'
  end

  def new
    @call = Call.new
  end

  def create
    @call = Call.new(params[:call])
    @call.creator = current_user.login
    @call.modifier = current_user.login

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
    params[:call][:modifier] = current_user.login
    if @call.update_attributes(params[:call])
      flash.now[:notice] = '更新成功.'
    end
    render :action => "new"
  end

end
