class RecordsController < ApplicationController
  def index
    @page = Record.paginate :conditions => params_condition, :page => params[:page], :per_page => 20, :order => 'id desc'
  end

  def create
    is_dail_in = (params[:kind] == 'dail_in')
    params[:kind] = is_dail_in ? 1 : 2
    @record = Record.create!(
      :kind => params[:kind],
      :dail => params[:dail],
      :receive => params[:receive],
      :wavfile => params[:wavfile]
    )
    if is_dail_in
      redirect_to conversations_path(:record_id => @record.id, :phone => @record.dail)
    else
      redirect_to events_path(:record_id => @record.id, :phone => @record.receive)
    end
  end
end
