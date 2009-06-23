class HomeController < ApplicationController
  layout nil
  
  def head
    @menus = Resource.top
  end
end
