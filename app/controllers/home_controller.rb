class HomeController < ApplicationController
  before_filter :must_login
end
