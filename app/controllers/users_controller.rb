class UsersController < ApplicationController
  layout 'facebox', :only => ["edit", "update"]
  layout 'application', :only => ["new", "create"]

  # render new.rhtml
  def new
    @list = User.all :order => "login"
  end

  def create
    @user = User.new(params[:user])
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
    if user.update_attributes(params[:user])
      flash[:notice] = "编辑用户成功!"
      redirect_to new_user_path
      return
    end
    render :action => 'edit'
  end
end
