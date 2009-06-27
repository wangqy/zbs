class HomeController < ApplicationController
  skip_before_filter :check_permission

  layout nil
  
  def head
    @menu_hash = Resource.menu_hash_from(current_user)
    @menus = Resource.menu_from(@menu_hash)
  end

  def index
    resource = current_user.resources.first 
    if resource
      @main_path = resource.path 
    else
      @main_path = "/home/no_right"
    end
  end
end
