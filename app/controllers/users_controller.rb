class UsersController < ApplicationController
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

end
