module EventsHelper
  #@param "callnumber"
  #@return 来电电话
  def l(field)
    t("activerecord.attributes.#{params[:type].downcase}.#{field}")
  end
  
  #字段中文label,必填
  #@param "callnumber"
  #@return 来电电话
  def lr(field)
    "#{l(field)} #{require_star}"
  end

  #@param @event
  #@param "callnumber"
  #@return 来电电话
  def el(field)
    t("activerecord.attributes.#{@event.class.model_name.downcase}.#{field}")
  end

  def select_kind(kind)
    kind ||= Kind.new
    options = []
    parent = Kind.parent_list
    parent.each do |p|
      options << [p.name, p.id]
      p.childrens.each do |c|
        options << ["#{p.name} #{c.name}", c.id]
      end
    end
    select_tag 'event[kind_id]', options_for_select(options, kind.id)
  end
end
