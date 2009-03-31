class EmployeesController < ApplicationController
  def index
    @list = Employee.paginate :page => params[:page], :order => 'created_at desc'
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(params[:employee])
    @employee.creator = current_user.login
    @employee.modifier = current_user.login

    if @employee.save
      flash[:notice] = '保存成功'
      redirect_to :action => "new"
    else
      render :action => "new"
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    render :action => "new"
  end

  def update
    @employee = Employee.find(params[:id])
    params[:employee][:modifier] = current_user.login
    if @employee.update_attributes(params[:employee])
      flash[:notice] = '更新成功'
      redirect_to employees_path
    else
      flash[:notice] = '更新失败'
      render :action => "new"
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    if @employee.destroy
      flash[:notice] = '删除成功'
    else
      flash[:notice] = '删除失败'
    end
    redirect_to employees_path
  end

  def show
    @employee = Employee.find(params[:id])
    render :action => "show"
  end
end
