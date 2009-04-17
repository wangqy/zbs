class KindsController < ApplicationController
  layout 'facebox'

  def new
    @parent_list = Kind.parent_list
    @kind = Kind.new
  end

  def create
    @kind = Kind.create(params[:kind])
    if @kind.errors.empty?
      flash.now[:notice] = m('kind.create.success')
      Log.create @kind, current_user, request.remote_ip
      render :partial => "share/update_success"
    else
      render :partial => "share/update_failure", :locals => { :objname => 'kind' }
    end
  end

end
