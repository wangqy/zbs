class NoticesController < ApplicationController
  def index
    if params[:notice].nil?
      params[:notice] = {}
    end
    @list = Notice.paginate :per_page =>10, :conditions => params_condition, :page => params[:page], :order => 'created_at DESC'
  end
  
  def list 
    if params[:notice].nil?
      params[:notice] = {}
    end
    params[:notice][:deployed] = 1
    @conditions = condition params, "notice"
    @list = Notice.all :conditions => @conditions, :limit => 3, :order => 'created_at DESC'
  end

  def show
    @notice = Notice.find(params[:id])
  end
  
  def destroy
    begin
      @notice = Notice.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @notice = nil
    end
    
    if (!@notice.nil?) && @notice.destroy
      flash[:notice] = m('notice.delete.success')
      Log.delete @notice, current_user, request.remote_ip
      redirect_to notices_path
    else
      flash[:notice] = m('notice.delete.failure')
      redirect_to notices_path
    end
  end

  def new
    @notice = Notice.new
    @notice.deployed = 0
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
    #发布
    if @notice.deployed == 0 && params[:notice][:deployed] == '1'
      @notice.deployee = current_user
      @notice.deployed_at = Time.now
    end
    params[:notice][:modifier] = current_user
    if @notice.update_attributes(params[:notice])
      flash[:notice] = m('notice.update.success')
      Log.update @notice, current_user, request.remote_ip
      redirect_to notices_path
    else
      render :action => "new"
    end
  end
end
