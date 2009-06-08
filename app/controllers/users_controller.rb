class UsersController < ApplicationController
  #列表
  def index
    if params[:user].nil?
      params[:user] = {}
    end
    @page = User.paginate :page => params[:page], :conditions => params_condition, :per_page => 10, :order => "login"
  end

  #新增
  def new
    @user = User.new
  end

  #保存
  def create
    @user = User.new(params[:user])
    #默认不禁用
    @user.disabled = 0
    @user.creator = current_user
    @user.modifier = current_user

    @user.save
    if @user.errors.empty?
      flash[:notice] = m('user.create.success') 
      Log.create @user, current_user, request.remote_ip
      if params[:commit] == t('html.button.save')
        @user = User.new
        redirect_to new_user_path
      else
        redirect_to users_path
      end
    else
      render :action => 'new'
    end
  end

  #编辑
  def edit
    @user = User.find_by_id(params[:id])
  end

  #更新
  def update
    @user = User.find(params[:id])
    params[:user][:modifier] = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = m('user.update.success')
      Log.update @user, current_user, request. remote_ip
      redirect_to users_path
    else
      render :action => "edit"
    end
  end
=begin
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    if @user.errors.empty?
      flash[:notice] = m('user.delete.success')
    else
      flash[:notice] = m('user.delete.failure')
    end
    redirect_to users_path
  end
=end

  #禁用
  def disable
    @user = User.find(params[:id])
    @user.update_attribute(:disabled, 1)
    if @user.errors.empty?
      Log.disable @user, current_user, request.remote_ip
      flash[:notice] = m('user.disable.success')
    else
      flash[:notice] = m('user.disable.failure')
    end
    redirect_to users_path
  end

  #启用
  def enable
    @user = User.find(params[:id])
    @user.update_attribute(:disabled, 0)
    if @user.errors.empty?
      Log.enable @user, current_user, request.remote_ip
      flash[:notice] = m('user.enable.success')
    else
      flash[:notice] = m('user.enable.failure')
    end
    redirect_to users_path
  end

  #修改密码
  def pass
    @user = User.new
  end

  #更新密码
  def updatepass
    @user = User.find(current_user)
    params[:user][:modifier] = current_user
    if @user.update_attributes(params[:user])
      Log.pass @user, current_user, request.remote_ip
      flash[:notice] = m('user.pass.success')
    end
    render :action => :pass
  end

  #更新坐席号
  def updatesite
    @user = User.find(current_user)
    params[:user][:modifier] = current_user
    if @user.update_attributes(params[:user])
      Log.site @user, current_user, request.remote_ip
      flash[:notice] = m('user.site.success')
      render :partial => "update_success_redirect"
    else
      render :partial => "share/update_failure", :locals => { :objname => 'user' }
    end
  end

  #获取部门人员
  def dept
    @list = []
    unless params[:id].empty?
      @list = User.find_all_by_department_id(params[:id])
    end
    render :partial => "dept_user", :layout => false
  end

end
