# Controller responsible for handling CRUD operations for Scrap objects.
# frozen_string_literal: true

class ScrapsController < ApplicationController
  require 'csv'
  require 'httparty'
  require 'nokogiri'

  def index
    @scraps = Scrap.all
    @scrap_queries = Scrap.pluck(:queries)
  end

  def new
    @scrap = Scrap.new
  end

  def create
    @scrap = Scrap.create(:csv_file_name => params[:scrap][:csv_file_name], :user_id => current_user.id)

    file_path = @scrap.csv_file_name.path
    @csv_content = process_csv_file(file_path)

    if @scrap.save
      queries = []
      @csv_content.map { |row|
        queries << row[0]
      }
      @scrap.update(queries: queries)
      flash[:notice] = 'Scrap was successfully created.'
      render :index

    else

      redirect_to '/scraps/index'
      flash[:alert] = 'Scrap was not created.'

    end
  end

  def process_csv
    # Get the uploaded CSV file from the first Scrap record for simplicity
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
    # Use CSV.parse to read the content of the CSV file
    csv_content = File.read(file_path)
    CSV.parse(csv_content, headers: false)
  end

  def get_data(search_term)
    result = []
    formatted_search_term = search_term.gsub(' ', '+')
    url = "https://www.google.com/search?q=#{formatted_search_term}&gl=us"
    headers = {
      "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36"
    }
    # Format the search term for the Google search URL

    unparsed_page = HTTParty.get(url, headers: headers)
    parsed_page = Nokogiri::HTML(unparsed_page.body)
    # Extract the number of advertisers (sponsored results) from the page
    advertisers_count = parsed_page.css('span:contains("Sponsored")').count
    result_stats = parsed_page.css('#result-stats').text
    links = parsed_page.css('a').count
    # Save the HTML code of the page to a file
    file_path = "#{formatted_search_term}_page.html"
    File.write(file_path, parsed_page.to_html)

    html_content = File.read(file_path)

    result.push(advertisers_count, result_stats, links, html_content)

    result
  end

  def scrap_params
    params.require(:scrap).permit(:csv_file_name)
  end
end
