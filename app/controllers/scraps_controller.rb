# Controller responsible for handling CRUD operations for Scrap objects.
# frozen_string_literal: true

class ScrapsController < ApplicationController
  require 'csv'
  require 'httparty'
  require 'nokogiri'

  def index
    @scraps = current_user.scraps
    @scrap_queries = Scrap.pluck(:queries)
  end

  def show
    @scrap = Scrap.find(params[:id])
    @scrap_detail = @scrap.scrap_details
    @search = params[:search]
    if @search.present?
      @scrap_detail = @scrap.scrap_details.where('query LIKE ?', "%#{@search}%")
    else
      @scrap_detail = @scrap.scrap_details
    end



  end
  


  def new
    @scrap = Scrap.new
  end

  def create
    @scrap = Scrap.new(csv_file_name: params[:scrap][:csv_file_name], user_id: current_user.id)

    file_path = @scrap.csv_file_name.path
    @csv_content = process_csv_file(file_path)

    if @scrap.save
      temquery = []
      @csv_content.each do |row|
        query = row[0]
        next if query.nil? || query.blank?

        temquery.push(query)
        Scrap.update(@scrap.id, queries: temquery)
        data = get_data(query)
        @scrap_detail = ScrapDetail.create(
          addWords: data[0],
          stats: data[1],
          links: data[2],
          html_cache: data[3],
          scrap_id: @scrap.id,
          query: query
        )
      end

      flash[:notice] = 'Scrap was successfully created.'
      redirect_to scraps_path
    else
      flash[:alert] = 'Scrap was not created.'
      render :new
    end
  end

  def process_csv
    @scrap = Scrap.find(params[:id])
    if @scrap.present? && @scrap.csv_file_name.present?
      file_path = @scrap.csv_file_name.path
      @csv_content = process_csv_file(file_path)
    else
      flash[:alert] = 'No CSV file found.'
      redirect_to scraps_path
    end
  end

  private
def process_csv_file(file_path)

    csv_content = []  
    CSV.foreach(file_path, headers: true) do |row|
      csv_content.push(row)
    end
    csv_content
  end

  

  def get_data(search_term)
    result = []
    formatted_search_term = search_term.gsub(' ', '+')
    url = "https://www.google.com/search?q=#{formatted_search_term}=en-US"

    headers = [
      { "User-Agent":
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" },
      { "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36" },
      { "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36" },
      { "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36" },
      { "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36" },
      { "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36" }
    ]
    unparsed_page = HTTParty.get(url, headers: headers.sample, follow_redirects: true)
    parsed_page = Nokogiri::HTML(unparsed_page.body)

    advertisers_count = parsed_page.css('span').count
    result_stats = parsed_page.css('#result-stats').text
    links = parsed_page.css('a').count
    html_content = parsed_page.to_html
    result.push(advertisers_count, result_stats, links, html_content)
    sleep(2)
    result
  end

  def scrap_params
    params.require(:scrap).permit(:csv_file_name)
  end
end
