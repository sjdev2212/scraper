class ScrapDetailsController < ApplicationController
    def index
        @scrap_details = ScrapDetail.all
    end
    def show
        @scrap_detail = ScrapDetail.find(params[:id])
    end

    private 

    def scrap_detail_params
        params.require(:scrap_detail).permit(:addWords, :stats, :links, :html_cache, :scrap_id)
    end
end
