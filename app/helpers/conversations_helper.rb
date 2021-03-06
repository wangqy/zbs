module ConversationsHelper
  #选择事件分类
  def select_kind(kind)
    kind ||= Kind.new
    options = []
    parent = Kind.parent_list
    parent.each do |p|
      parent_label = p.name
      parent_label += "(限期#{p.days}天)" if p.days>0
      options << [parent_label, p.id]
      p.childrens.each do |c|
        child_label = "#{p.name} #{c.name}"
        child_label += "(限期#{p.days}天)" if p.days>0
        options << [child_label, c.id]
      end
    end
    select_tag 'conversation[kind_id]', options_for_select(options, kind.id), :class => "long"
  end

  #选择联系人
  def select_person(conversation = @conversation)
    html = ""
    conversation.people.each do |p|
      html += render(:partial => "people/link", :locals => { :p => p, :selected => (p.id == @event.person_id) })
    end
    html
  end

  #来电来访
  def is_category_in?
    params[:category] == 'category_in'
  end
end
