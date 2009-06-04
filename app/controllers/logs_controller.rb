class LogsController < ApplicationController
  #列表
  def index
    @conditions = ["1=1 "]
    if params[:log].nil?
      params[:log] = {}
    else
      unless params[:log][:modulename].blank?
        @conditions[0] += "and modulename like ?"
        @conditions<<"%#{params[:log][:modulename]}%"
      end
      unless params[:log][:operate].blank?
        @conditions[0] += " and operate = ?"
        @conditions<< params[:log][:operate]
      end
      unless params[:log][:operator].blank?
        @conditions[0] += " and u.realname like ?"
        @conditions<< "%#{params[:log][:operator]}%"
      end
    end
    
    @list = Log.paginate :joins => [" inner join users as u on operator_id = u.id"], :per_page => 10, :conditions => @conditions, :page => params[:page], :order => "operatedate desc"
  end
end
