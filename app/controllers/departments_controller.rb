class DepartmentsController < ApplicationController
  def index
=begin
    @conditions = []
    @conditions[0] = "1=1"
    unless params[:department].nil?
      params[:department].keys.each do |key|
        #puts params[:department][key]
        #puts params[:department]["name"]
        unless params[:department][key].blank?
          @conditions[0] += " and #{key} like ?"
          @conditions<<"%#{params[:department][key]}%"
        end
      end
=end
    @conditions = condition params, "department"
    if params[:department].nil?
      params[:department] = {}
    end
    @list = Department.paginate :conditions => @conditions, :page => params[:page], :order => 'created_at DESC'
  end

  def show
    @department = Department.find(params[:id])
  end
  
  def destroy
    @department = Department.find(params[:id])
    if @department.destroy
      flash[:notice] = '删除成功'
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
