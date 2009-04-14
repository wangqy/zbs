module ActionView::Helpers::FormTagHelper
  alias_method :orig_radio_button_tag, :radio_button_tag
  #根据params对应的值,判断是否选中
  def radio_button_tag(name, value, checked = false, options = {})
    options.merge! :class => "radio"
    #history[:handle]
    regexp_name = name.to_s.match(/(.*)\[:*(.*)\]/)
    first_pretty_name = regexp_name[1]
    second_pretty_name = regexp_name[2]
    checked = (params[first_pretty_name][second_pretty_name]==value.to_s) if params[first_pretty_name]
    orig_radio_button_tag(name, value, checked, options)
  end

  alias_method :orig_submit_tag, :submit_tag
  #默认加入:class => "submit"
  def submit_tag(value, options = {})
    options[:class] ||= "submit"
    orig_submit_tag value, options
  end

end
