class UsersController < ApplicationController
  layout 'facebox', :only => ["edit", "update","pass", "updatepass"]
  layout 'application', :only => ["new", "create", "custom", "customed"]

  # render new.rhtml
  def new
    @user = User.new
    @list = User.all :order => "login"
  end

  def create
    @user = User.new(params[:user])
    @user.creator = current_user
    @user.modifier = current_user

    @user.save
    if @user.errors.empty?
      flash.now[:notice] = "新增用户成功!"
      @user = User.new
    end
    @list = User.all :order => "login"
    render :action => 'new'
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    user = User.find(params[:id])
    params[:user][:modifier] = current_user
    if user.update_attributes(params[:user])
      flash[:notice] = "编辑用户成功!"
      redirect_to new_user_path
      return
    end
    render :action => 'edit'
  end

  def pass
    @user = User.new
  end

  def updatepass
    user = User.find(current_user)
    params[:user][:modifier] = current_user
    p params
    p user
    if user.update_attributes(params[:user])
      flash[:notice] = "密码修改成功"
      #redirect_to root_path
    else
      flash[:notice] = "密码修改失败"
    end
    render :partial => "updatepass_success"
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
