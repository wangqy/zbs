class HomeController < ApplicationController
  layout nil
  
  def head
    @menu_hash = Resource.menu_hash_from(current_user)
    @menus = Resource.menu_from(@menu_hash)
  end
end
