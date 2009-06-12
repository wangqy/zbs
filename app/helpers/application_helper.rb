# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  #枚举下拉列表
  #@param object_name 实体名称
  #@param method  枚举类型
  def select_enum(object_name, method)
    select_tag "#{object_name}[#{method}]", options_for_select(Enum.__send__(method))
  end

  #选择部门
  def select_dept
    options = select_dept_options
    options = [["未选择",""]] + options
    select_tag 'history[department_id]', options_for_select(options), :onchange => remote_function(:update=>:user_select, :url => {:controller => :users, :action => :dept}, :with => "'id=' + $('history_department_id').value")
  end

  def select_dept_options(list = Department.top, level = 0)
    options = []
    list.each do |dept|
      options += [["#{''.rjust(level,'>')}#{dept.name}", dept.id]]
      options += select_dept_options(dept.children, level+1)
    end
    options
  end

  #选择用户
  def select_user(list = User.all)
    options = list.collect {|d| [d.realname, d.id]}
    options = [["未选择",""]] + options
    select_tag 'history[user_id]', options_for_select(options)
  end

  #必填
  def require_star
    content_tag :span, "*", :class => "required"
  end

  #截取字符串,后带"更多"链接
  def truncate_with_more(text, length, id)
    return "" if text.blank?
    mb_text = text.mb_chars
    if mb_text.length > length
      result = mb_text[0, length].to_str
      result += "<span id='text_more_link_#{id}'>&hellip;"
      result += "<a href='#' onclick='$(\"text_more_#{id}\").show(); $(\"text_more_link_#{id}\").hide(); return false;'>"
      result += "显示更多</a></span>"
      result += "<span id='text_more_#{id}' style='display: none;'>"
      result += mb_text[length, mb_text.length].to_str
      result += "</span>"
    else
      result = text
    end
    result 
  end

  #获取I18n实体属性名称
  def tt(path)
    t("activerecord.attributes.#{path}")
  end

  #显示提示消息
  def flash_msg
    message = ""
    flash.each do |key, msg|
      message += content_tag :div, msg, :id => "flash-#{key}"
    end
    message
  end

end
