module ActionView::Helpers::FormTagHelper
  alias_method :orig_radio_button_tag, :radio_button_tag
  #根据params对应的值,判断是否选中
  def radio_button_tag(name, value, checked = false, options = {})
    options.merge! :class => :radio
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

module ActionView::Helpers::FormHelper
  def label_with_model(object_name, method, text = nil, options = {})
    text ||= t("activerecord.attributes.#{object_name}.#{method}", :default => "")
    text += content_tag(:span, "*", :class => "required") if options[:require]
    label_without_model object_name, method, text, options
  end
  #直接根据method获取cn.yml中定义的文本
  #如f.label :phone,返回内容为"联系电话"的label,f为case的form
  alias_method_chain :label, :model

  def radio_button_with_class(object_name, method, text = nil, options = {})
    options.merge! :class => :radio
    radio_button_without_class object_name, method, text, options
  end
  #为radio加上默认的class:radio
  alias_method_chain :radio_button, :class
end

class ActionView::Helpers::FormBuilder
  #必填项,即标记后加"*"
  def label_require(method, text = nil, options = {})
    options[:require] = true
    label(method, text, options)
  end
end
