# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def select_menu(menu)
    "selected" if is_menu(menu)
  end

  def is_menu(menu)
    @menu == menu
  end

  def is_admin?
    ['cogentsoft', 'admin'].include?current_user.login
  end

  #枚举下拉列表
  #@param object_name 实体名称
  #@param method  枚举类型
  def select_enum(object_name, method)
    select_tag "#{object_name}[#{method}]", options_for_select(Enum.__send__(method))
  end

  #选择部门
  def select_dept
    options = Department.all.collect {|d| [d.name, d.code]}
    options = [["未选择",""]] + options
    select_tag 'history[department_code]', options_for_select(options)
  end

  def dept_responser_json
    department = Department.all.collect{|d| {d.code => d.manager}}
    responser = department.inject({}){|hashes, item| hashes.merge!(item)} 
    ActiveSupport::JSON.encode(responser)
  end

  #必填
  def require_star
    content_tag :span, "*", :class => "required"
  end
end
