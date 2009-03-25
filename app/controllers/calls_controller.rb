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
  end

  def create
    @call = Call.new(params[:call])
    @call.creator = current_user.login
    @call.modifier = current_user.login

    if @call.save
      flash[:notice] = '保存成功.'
      if params[:commit]==t('html.button.save')
        redirect_to new_call_path
      else
        redirect_to edit_call_path(@call)
      end
    else
      render :action => "new"  
    end
  end

  def edit
    @call = Call.find(params[:id])
    render :action => "new"
  end

  def update
    @call = Call.find(params[:id])
    params[:call][:modifier] = current_user.login
    if @call.update_attributes(params[:call])
      flash[:notice] = '更新成功.'
      if params[:commit]==t('html.button.save')
        redirect_to new_call_path
      else
        redirect_to edit_call_path
      end
    else
      render :action => "new"
    end
  end

  def show
    @call = Call.find(params[:id])
  end

end
