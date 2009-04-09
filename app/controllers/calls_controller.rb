class CallsController < ApplicationController
  def index
    #TODO make this finder dynamic
    if !params[:callnumber].blank? && !params[:name].blank?  
      @condition = ['callnumber like ? and name like ?', "%#{params[:callnumber]}%", "%#{params[:name]}%"]
    elsif !params[:callnumber].blank?
      @condition = ['callnumber like ?', "%#{params[:callnumber]}%"]
    elsif !params[:name].blank?
      @condition = ['name like ?', "%#{params[:name]}%"]
    end
    @list = Call.paginate :conditions => @condition, :page => params[:page], :order => 'created_at DESC'
  end

  def new
    @call = Call.new
    @call.timing = DateTime.now.to_s(:with_year)
    @call.callnumber = params[:callnumber] if params[:callnumber]
    @list = relate_list(@call)
  end

  def create
    @call = Call.new(params[:call])
    @call.creator = current_user
    @call.modifier = current_user

    #TODO: 来电编号
    @call.calltag = "深电#{Date.today.to_s(:serial)}00009"

    if @call.save
      flash[:notice] = '保存成功.'
      if params[:commit]==t('html.button.save')
        redirect_to new_call_path
      else
        redirect_to edit_call_path(@call)
      end
    else
      @list = relate_list(@call)
      render :action => "new"  
    end
  end

  def edit
    @call = Call.find(params[:id])
    @list = relate_list(@call)
    render :action => "new"
  end

  def update
    @call = Call.find(params[:id])
    params[:call][:modifier] = current_user
    if @call.update_attributes(params[:call])
      flash[:notice] = '更新成功.'
      if params[:commit]==t('html.button.save')
        redirect_to new_call_path
      else
        redirect_to edit_call_path
      end
    else
      @list = relate_list(@call)
      render :action => "new"
    end
  end

  def show
    @call = Call.find(params[:id])
    @list = relate_list(@call)
  end

  def destroy
    @call = Call.find(params[:id])
    if(@call.state != 0)
      flash[:errors] = "事件已安排,不能删除."
    else
      flash[:notice] = "事件删除成功."
      @call.destroy
    end
    redirect_to :back
  end

  private
  def relate_list(call)
    list = call.callnumber ? Call.search(call.callnumber, :order => :created_at): []
    list.reject! {|c| c.id == call.id} unless call.new_record?
    list
  end

end
