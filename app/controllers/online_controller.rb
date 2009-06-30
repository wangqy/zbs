class OnlineController < ApplicationController
  def index
    @departments = Department.all
  end

end
