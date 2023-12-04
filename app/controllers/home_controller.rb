class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @scraps = current_user.present? ? current_user.scraps : []
  end
end
