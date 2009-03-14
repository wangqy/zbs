class UsersController < ApplicationController
  # render new.rhtml
  def new
  end

  def create
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      flash.now[:notice] = "新增用户成功!"
    end
    render :action => 'new'
  end

end
