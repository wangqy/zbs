module EventsHelper
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
end
