class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  before_filter :must_login

  # render new.rhtml
  def new
  end

  def create
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      flash[:notice] = "新增用户成功!"
    end
    render :action => 'new'
  end

end
