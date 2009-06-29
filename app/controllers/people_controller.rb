class PeopleController < ApplicationController
  skip_before_filter :check_permission

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(params[:person])
    @person.creator = current_user
    @person.modifier = current_user
    if @person.save
      flash.now[:notice] = m('person.create.success')
      Log.create @person, current_user, request.remote_ip
      render :partial => "create_success"
    else
      render :partial => "share/update_failure", :locals => { :objname => 'person' }
    end
  end

  def edit
    @person = Person.find(params[:id])
    render :action => "new"
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      flash.now[:notice] = m('person.update.success')
      Log.update @person, current_user, request.remote_ip
      render :partial => "update_success"
    else
      render :partial => "share/update_failure", :locals => { :objname => 'person' }
    end
  end

end
