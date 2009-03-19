# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def select(menu)
    "selected" if @menu == menu
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
end
