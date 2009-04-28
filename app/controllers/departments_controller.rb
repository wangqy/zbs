class DepartmentsController < ApplicationController
  def index
    @conditions = condition params, "department"
    if params[:department].nil?
      params[:department] = {}
    end
    @list = Department.paginate :per_page =>10, :conditions => @conditions, :page => params[:page], :order => 'created_at DESC'
  end

  def show
    @department = Department.find(params[:id])
  end
  
  def destroy
    begin
      @department = Department.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @department = nil
    end
    if (!@department.nil?) && @department.destroy
      flash[:notice] = m('department.delete.success')
      Log.delete @department, current_user, request.remote_ip
      redirect_to departments_path
    else
      flash[:notice] = m('department.delete.failure')
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
      flash[:notice] = m('department.create.success')
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
      flash[:notice] = m('department.update.success')
      Log.update @department, current_user, request.remote_ip
      redirect_to departments_path
    else
      render :action => "new"
    end
  end
end
