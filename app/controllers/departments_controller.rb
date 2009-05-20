class DepartmentsController < ApplicationController
  def index
    render :partial => 'child', :collection => Department.find(params[:department_id]).children
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
    if request.xhr?
      @parent = Department.find(params[:department_id])
      @department.parent = @parent
      render :partial => "new" and return
    end
  end

  def create
    @department = Department.new(params[:department])
    @department.creator = current_user
    @department.modifier = current_user

    if @department.save
      flash.now[:notice] = "#{m('department.create.success')},可以继续新增."
      Log.create @department, current_user, request.remote_ip
    else
      render :partial => "share/update_failure", :locals => { :objname => 'department' }
    end
  end

  def edit
    @department = Department.find(params[:id])
    render :action => "edit", :layout => false
  end

  def update
    @department = Department.find(params[:id])
    params[:department][:modifier] = current_user
    if @department.update_attributes(params[:department])
      flash.now[:notice] = m('department.update.success')
    else
      render :partial => "share/update_failure", :locals => { :objname => 'department' }
    end
  end
end
