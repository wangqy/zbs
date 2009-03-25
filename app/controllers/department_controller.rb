class DepartmentController < ApplicationController
  def index
    @list = Department.paginate :page => params[:page], :order => 'created_at DESC'
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(params[:department])
    @department.creator = current_user.login
    @department.modifier = current_user.login

    if @department.save
      flash[:notice] = '保存成功.'
      redirect_to edit_department_path(@department)
    else
      render :action => "new"  
    end
  end

  def edit
    @department = Department.find(params[:id])
    render :action => "new"
  end

  def update
    @department = Department.find(params[:id])
    params[:department][:modifier] = current_user.login
    if @department.update_attributes(params[:department])
      flash.now[:notice] = '更新成功.'
    end
    render :action => "new"
  end
end
