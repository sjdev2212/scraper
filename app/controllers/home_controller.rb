class HomeController < ApplicationController
  def index
    @scraps = current_user.present? ? current_user.scraps : []
  
  end
end
