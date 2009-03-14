# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def select(menu)
    "selected" if @menu == menu
  end
end
