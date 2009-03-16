# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def select(menu)
    "selected" if @menu == menu
  end

  def is_admin?
    ['cogentsoft', 'admin'].include?current_user.login
  end
end
