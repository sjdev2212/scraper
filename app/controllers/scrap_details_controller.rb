class ScrapDetailsController < ApplicationController
  def index
    @scrap_detail = ScrapDetail.find_by(scrap_id: params[:id], query: params[:query])
    @scrap = ScrapDetail.where(scrap_id: params[:id])
  end

  def show
    @scrap_detail = ScrapDetail.find(params[:id])
  end

  def new
    @scrap_detail = ScrapDetail.new
  end

  def create
    @scrap_detail = ScrapDetail.new(scrap_detail_params)
    if @scrap_detail.save
      redirect_to @scrap_detail
    else
      render 'new'
    end
  end

  private

  def scrap_detail_params
    params.require(:scrap_detail).permit(:addWords, :stats, :links, :html_cache, :scrap_id)
  end
end
