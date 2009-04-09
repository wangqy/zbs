class UsersController < ApplicationController
  layout 'facebox', :only => ["pass", "updatepass"]
  layout 'application', :only => ["index", "new", "create", "edit", "update", "custom", "customed"]

  # render new.rhtml

  def index
    @conditions = condition params, "user"
    if params[:user].nil?
      params[:user] = {}
    end
    @page = User.paginate :page => params[:page], :conditions => @conditions, :per_page => 10, :order => "login"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    #默认不禁用
    @user.disabled = 0
    @user.creator = current_user
    @user.modifier = current_user

    @user.save
    if @user.errors.empty?
      flash[:notice] = "新增用户成功!"
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

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    p params
    @user = User.find(params[:id])
    params[:user][:modifier] = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "编辑用户成功!"
      redirect_to users_path
    else
      render :action => "new"
    end
  end

  def disable
    @user = User.find(params[:id])
    @user.update_attribute(:disabled, 1)
    if @user.errors.empty?
      flash[:notice] = "禁用用户成功"
    else
      flash[:notice] = "禁用用户失败"
    end
    redirect_to users_path
  end

  def enable
    @user = User.find(params[:id])
    @user.update_attribute(:disabled, 0)
    if @user.errors.empty?
      flash[:notice] = "启用用户成功"
    else
      flash[:notice] = "启用用户失败"
    end
    redirect_to users_path
  end

  def pass
    @user = User.new
  end

  def updatepass
    @user = User.find(current_user)
    params[:user][:modifier] = current_user
    #p params
    #p user
    if @user.update_attributes(params[:user])
      flash.now[:notice] = "密码修改成功"
      render :partial => "update_success"
      #redirect_to root_path
    else
      render :partial => "update_failure"
    end
  end
=begin
  def custom
    @menu = "personal"
    @user = User.find(current_user)
    #p @user
  end

  def customed
    @menu = "personal"
    user = User.find(current_user);
    params[:user][:modifier] = current_user
    if user.update_attributes(params[:user])
      flash[:notice] = "个人信息更新成功"
    else
      flash[:notice] = "个人信息更新失败"
    end
  end
=end
end
