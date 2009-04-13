class DepartmentsController < ApplicationController
  def index
    @conditions = condition params, "department"
    if params[:department].nil?
      params[:department] = {}
    end
    @list = Department.paginate :per_page =>1, :conditions => @conditions, :page => params[:page], :order => 'created_at DESC'
  end

  def show
    @department = Department.find(params[:id])
  end
  
  def destroy
    @department = Department.find(params[:id])
    if @department.destroy
      flash[:notice] = '删除成功'
      Log.delete @department, current_user, request.remote_ip
      redirect_to departments_path
    elsif
      flash[:notice] = '删除失败'
      redirect_to departments_path
    end
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(params[:department])
    @department.creator = current_user
    @department.modifier = current_user

    if @department.save
      flash[:notice] = '保存成功.'
      Log.create @department, current_user, request.remote_ip
      if params[:commit]==t('html.button.save')
        redirect_to new_department_path
      else
        redirect_to departments_path
      end
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
    params[:department][:modifier] = current_user
    if @department.update_attributes(params[:department])
      flash.now[:notice] = '更新成功.'
      Log.update @department, current_user, request.remote_ip
      if params[:commit]==t('html.button.save')
        redirect_to new_department_path
      else
        redirect_to departments_path
      end
    else
      render :action => "new"
    end
  end
end
