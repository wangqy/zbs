module WorkitemsHelper
  def warning(workitem)
    if workitem.created_at.advance(:days => Workitem::WARNING_DAYS).past?
      content_tag :span, "(警)", :class => :warning, :title => "您在#{workitem.created_at.to_s(:db)}接到事件处理任务,距今已经超过#{Workitem::WARNING_DAYS}天"
    end
  end
end
