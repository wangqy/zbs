# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  #Don't check AuthenticityToken for 'create' action
  protect_from_forgery :except => :create
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
      if current_user.disabled == 1
        quit_user
        flash[:notice] = m('user.login.disabled')
        render :action => 'new'
      else
        if params[:remember_me] == "1"
          current_user.remember_me unless current_user.remember_token?
          cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
        end
        flash[:notice] = m('user.login.success')
        Log.login current_user, request.remote_ip
        redirect_to_homepage
      end
    else
      flash.now[:error] = m('user.login.password')
      render :action => 'new'
    end
  end

  def destroy
    quit_user
    flash[:notice] = m('user.logout.success')
    Log.logout current_user, request.remote_ip
    redirect_to login_path
  end

  private
  def quit_user
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
  end

  private
  def redirect_to_homepage
    redirect_to home_path
  end
end
