module ActionView::Helpers::FormTagHelper
  alias_method :orig_radio_button_tag, :radio_button_tag
  def radio_button_tag(name, value, checked = false, options = {})
    #history[:handle]
    regexp_name = name.to_s.match(/(.*)\[:*(.*)\]/)
    first_pretty_name = regexp_name[1]
    second_pretty_name = regexp_name[2]
    checked = (params[first_pretty_name][second_pretty_name]==value.to_s) if params[first_pretty_name]
    orig_radio_button_tag(name, value, checked, options)
  end

end
