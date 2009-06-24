# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionLoggable
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
      #转办,申请办结,自己受理,受理
      if [10,30].include?(history.handle)
        workitem_attributes = {:store_id => history.user_id}
      elsif [20,21].include?(history.handle)
        workitem_attributes = {:store_id => current_user.id}
      #退回,退回重办
      elsif [40,41].include?(history.handle)
        workitem_attributes = {:store_id => last_workitem.last_store_id}
      end
  end

  #获取查询sql,integer用=匹配,其他均用like匹配
  #@param params
  #@name  name[queryField]
  #@return ["1=1 and field like ?", "%fieldValue%"]
  def condition(param, name = nil)
    modelName =  controller_name.capitalize.singularize
    c = eval modelName
    conditions = []
    conditions[0] = "1=1"
    name = controller_name.singularize if name.blank?
    unless param[name].nil?
      param[name].keys.each do |key|
        unless param[name][key].blank?
          c_h = c.columns_hash
          if c_h.has_key? key
            t = c_h[key].type.to_s
          else
            t = 'string'
          end
          unless t == 'integer'
            conditions[0] += " and #{key} like ?"
            conditions<<"%#{param[name][key]}%"
          else
            conditions[0] += " and #{key} = ?"
            conditions<<"#{param[name][key]}"
          end
        end
      end
    end
    conditions
  end

  def params_condition
    condition params
  end

  #获取操作结果提示信息
  #@path 'user.create.success' 'user.create.failure'
  # user 为定义在activerecord.models下的model name
  #m('user.create.success') => 新增用户成功
  def m(path)
    a = path.split('.')
    m = t("activerecord.models.#{a[0]}")
    s = t("msg.#{a[1]}.#{a[2]}", :model => m)
  end
  
  #高亮显示页面出错项
  ActionView::Base.field_error_proc = Proc.new{|html_tag, instance| %(<span class="fieldWithErrors">#{html_tag}</span>)}
end
