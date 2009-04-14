class NoticesController < ApplicationController
  def index
    @conditions = condition params, "notice"
    if params[:notice].nil?
      params[:notice] = {}
    end
    @list = Notice.paginate :per_page =>10, :conditions => @conditions, :page => params[:page], :order => 'created_at DESC'
  end

  def show
    @notice = Notice.find(params[:id])
  end
  
  def destroy
    @notice = Notice.find(params[:id])
    if @notice.destroy
      flash[:notice] = m('notice.delete.success')
      Log.delete @notice, current_user, request.remote_ip
      redirect_to notices_path
    elsif
      flash[:notice] = m('notice.delete.failure')
      redirect_to notices_path
    end
  end

  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new(params[:notice])
    @notice.creator = current_user
    @notice.modifier = current_user

    #发布
    if @notice.deployed == 1
      @notice.deployee = current_user
      @notice.deployed_at = Time.now
    end

    if @notice.save
      flash[:notice] = m('notice.create.success')
      Log.create @notice, current_user, request.remote_ip
      if params[:commit]==t('html.button.save')
        redirect_to new_notice_path
      else
        redirect_to notices_path
      end
    else
      render :action => "new"  
    end
  end

  def edit
    @notice = Notice.find(params[:id])
    render :action => "new"
  end

  def update
    @notice = Notice.find(params[:id])
    params[:notice][:modifier] = current_user
    if @notice.update_attributes(params[:notice])
      flash[:notice] = m('notice.update.success')
      Log.update @notice, current_user, request.remote_ip
      if params[:commit]==t('html.button.save')
        redirect_to new_notice_path
      else
        redirect_to notices_path
      end
    else
      render :action => "new"
    end
  end
end
