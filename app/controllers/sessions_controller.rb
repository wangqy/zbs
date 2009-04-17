# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  skip_before_filter :must_login, :destroy

  layout 'login'

  # render new.rhtml
  def new
    if logged_in?
      redirect_to_homepage
    end
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      flash[:notice] = "登录成功."
      redirect_to_homepage
    else
      flash.now[:error] = "错误的用户名或密码."
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "成功退出."
    redirect_to login_path
  end

  private
  def redirect_to_homepage
    if [1,2].include? current_user.role
      redirect_to(home_path)
    else
      redirect_to workitems_path
    end
  end
end
