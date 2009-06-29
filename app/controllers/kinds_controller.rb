class KindsController < ApplicationController
  skip_before_filter :check_permission

  def new
    @parent_list = Kind.parent_list
    @kind = Kind.new
  end

  def create
    @kind = Kind.create(params[:kind])
    if @kind.errors.empty?
      flash.now[:notice] = m('kind.create.success')
      Log.create @kind, current_user, request.remote_ip
      render :partial => "update_success"
    else
      render :partial => "share/update_failure", :locals => { :objname => 'kind' }
    end
  end

end
