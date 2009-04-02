# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  before_filter :set_menu
  before_filter :must_login

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9b790818f0cc793191f042e27b5ac4ce'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  #Creates an HistoryEntry record
  def history_log (event, options={})
    source = options.delete(:source) || current_user.login
    OpenWFE::Extras::HistoryEntry.log!(source, event, options)
  end
                  
  

  def must_login
    unless logged_in?
      redirect_to login_path
    end
  end

  def set_menu
    @menu = controller_name
  end

  #根据history属性handle判断,workitem的store_name存储的是用户名还是机构代码
  def workitem_attributes_from(history, last_workitem)
      workitem_attributes = nil
      #转办,申请办结
      if [10,30].include?(history.handle)
        workitem_attributes = {:store_name => history.department_code}
      #自己受理,受理
      elsif [20,21].include?(history.handle)
        workitem_attributes = {:store_name => current_user.login}
      #退回,退回重办
      elsif [40,41].include?(history.handle)
        workitem_attributes = {:store_name => last_workitem.store_name}
      end
  end

  #根据办理方式(handle)及当前事件状态,得出事件的下一状态
  def next_state_from(now_state, handle)
    matrix = {
      #未安排
      0 => {
        #转办(待处理),自己受理(已受理),直接办结(已办结)
        10 => 10,
        20 => 20,
        90 => 90
      },
      #待处理
      10 => {
        #转办(待处理),受理(已受理),申请办结(待审核),退回(已退回)
        10 => 10,
        21 => 20,
        30 => 30,
        40 => 40
      },
      #已受理
      20 => {
        #转办(待处理),申请办结(待审核)
        10 => 10,
        30 => 30
      },
      #已退回
      40 => {
        #转办(待处理),受理(已受理)
        10 => 10,
        21 => 20
      },
      #待重办
      50 => {
        #转办(待处理),受理(已受理),申请办结(待审核)
        10 => 10,
        21 => 20,
        30 => 30
      },
      #待审核
      30 => {
        #确认办结(已办结),退回重办(待重办)
        91 => 90,
        41 =>50
      }
    }
    matrix[now_state][handle]
  end
end
