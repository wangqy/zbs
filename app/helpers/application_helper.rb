# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def select_menu(menu)
    "selected" if is_menu(menu)
  end

  def is_menu(menu)
    @menu == menu
  end

  #@param "calls"
  #@return new_call_path
  def new_path(menu)
    send("new_#{menu.singularize}_path")
  end

  #@param "calls"
  #@return new_call_path
  def index_path(menu)
    send("#{menu}_path")
  end

  #@param "calls"
  #@return 来电
  def t_menu(menu)
    t('activerecord.models.' + menu.downcase.singularize)
  end

  def is_admin?(user=nil)
    user = current_user if user.nil?
    user.role == 1
  end

  def is_digit_person?(user=nil)
    user = current_user if user.nil?
    user.role == 2
  end

  def is_dispatch_person?(user=nil)
    user = current_user if user.nil?
    user.role == 3
  end

  def is_depart_person?(user=nil)
    user = current_user if user.nil?
    user.role == 4
  end

  def ismanager?
    current_user.ismanager == 1
  end

  #枚举下拉列表
  #@param object_name 实体名称
  #@param method  枚举类型
  def select_enum(object_name, method)
    select_tag "#{object_name}[#{method}]", options_for_select(Enum.__send__(method))
  end

  #选择部门
  def select_dept
    options = Department.all.collect {|d| [d.name, d.id]}
    options = [["未选择",""]] + options
    select_tag 'history[department_id]', options_for_select(options)
  end

  #获取部门负责人json格式的数据
  def dept_responser_json
    department = Department.all.collect{|d| {d.id => d.manager}}
    responser = department.inject({}){|hashes, item| hashes.merge!(item)} 
    ActiveSupport::JSON.encode(responser)
  end

  #必填
  def require_star
    content_tag :span, "*", :class => "required"
  end
  
end
