module ConversationsHelper
  #选择事件分类
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
    select_tag 'conversation[kind_id]', options_for_select(options, kind.id)
  end

  #选择联系人
  def select_person(conversation = @conversation)
    html = ""
    conversation.people.each do |p|
      html += radio_button_tag 'event[person_id]', p.id, p.id == @event.person_id
      html += label_tag "event_person_id_#{p.id}", p.name, :title => p.to_s, :id => "person_label_#{p.id}"
      html += "(#{link_to('改', edit_person_path(p), :rel => :facebox)})"
    end
    html
  end
end
