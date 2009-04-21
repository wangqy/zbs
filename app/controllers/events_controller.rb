class EventsController < ApplicationController
  def index
    #TODO make this finder dynamic
    if !params[:callnumber].blank? && !params[:name].blank?  
      @condition = ['callnumber like ? and name like ?', "%#{params[:callnumber]}%", "%#{params[:name]}%"]
    elsif !params[:callnumber].blank?
      @condition = ['callnumber like ?', "%#{params[:callnumber]}%"]
    elsif !params[:name].blank?
      @condition = ['name like ?', "%#{params[:name]}%"]
    end
    @list = dyna_event.paginate :conditions => @condition, :page => params[:page], :order => 'created_at DESC'
  end

  def new
    @event = dyna_event.new
    datetime = params[:datetime]
    if datetime
      @event.wavfile = params[:recordfile]
      datetime = datetime.to_datetime
      @event.timing = datetime.to_s(:with_year)
    else
      @event.timing = DateTime.now.to_s(:with_year)
    end
    @event.callnumber = params[:callnumber] if params[:callnumber]
    #值班室信息
    @event.watchman = current_user.realname
    @event.receiver = current_user.realname
    @event.manager = current_user.department.manager
    @list = search_relate_list_for(@event)
  end

  def create
    @event = dyna_event.new(params[:event])
    @event.creator = current_user
    @event.modifier = current_user

    #TODO: 来电编号
    @event.calltag = "深电#{Date.today.to_s(:serial)}00009"

    @event.init_case params[:event][:case_id]

    if @event.save
      flash[:notice] = '保存成功.'
      if params[:commit]==t('html.button.save')
        redirect_to new_event_path(@event)
      else
        redirect_to edit_event_path(@event)
      end
    else
      @list = relate_list(@event)
      render :action => "new"  
    end
  end

  def edit
    @event = dyna_event.find(params[:id])
    @list = relate_list(@event)
  end

  def update
    @event = dyna_event.find(params[:id])
    params[:event][:modifier] = current_user
    if @event.update_attributes(params[:event])
      flash[:notice] = '更新成功.'
      if params[:commit]==t('html.button.save')
        redirect_to new_event_path(@event)
      else
        redirect_to edit_event_path(@event)
      end
    else
      @list = relate_list(@event)
      render :action => "edit"
    end
  end

  def show
    @event = dyna_event.find(params[:id])
    @list = relate_list(@event)
  end

  def destroy
    @event = dyna_event.find(params[:id])
    if(@event.state != 0)
      flash[:errors] = "事件已安排,不能删除."
    else
      flash[:notice] = "事件删除成功."
      @event.destroy
    end
    redirect_to :back
  end

  private
  def search_relate_list_for(event)
    event.callnumber ? Case.search(event.callnumber, :order => :created_at): []
  end

  def relate_list(event)
    list = event.case.events.reject {|c| c ==event}
  end

  def dyna_event
    Kernel.const_get params[:type]
  end

  def new_event_path(event)
    send "new_#{event.class.model_name.singular}_path"
  end

  def edit_event_path(event)
    send "edit_#{event.class.model_name.singular}_path", event
  end

end
