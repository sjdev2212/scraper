# Controller responsible for handling CRUD operations for Scrap objects.
# frozen_string_literal: true

class ScrapsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_csv_file, only: :create

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

    if @csv_content.size > 100
      @scrap.errors.add(:base, 'Number of queries exceeds the limit (100).')
      flash[:alert] = 'Number of queries exceeds the limit (100).'
      render :new
      return
    end
    if @csv_content.size < 1
      @scrap.errors.add(:base, 'Number of queries is less than 1.')
      flash[:alert] = 'Number of queries is less than 1.'
      render :new
      return
    end

    if @scrap.save
      temquery = []
      @csv_content.each do |row|
        query = row[0]
        next if query.nil? || query.blank?

        temquery.push(query)
        Scrap.update(@scrap.id, queries: temquery)
        data = get_data(query)
        puts "Processing query: #{query}"
        puts "Data: #{data.inspect}"
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
      redirect_to scrap_path(@scrap)

    else
      if @scrap.errors[:csv_file_name].include?('file name already exists in the database')
        redirect_to new_scrap_path
        flash[:alert] = 'A file with that name already exists.'
      else
        flash[:alert] = 'Scrap was not created.'
      end

    end
  end

  def destroy
    @scrap = Scrap.find(params[:id])

    Rails.logger.debug("Before destroy: #{@scrap.inspect}")

    begin
      @scrap.destroy
      flash[:notice] = 'Scrap was successfully deleted.'
      redirect_to scraps_path
    rescue StandardError => e
      Rails.logger.error("Error during destroy: #{e.message}")
      flash[:alert] = "Failed to delete Scrap: #{e.message}"
      redirect_to scraps_path
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
    CSV.foreach(file_path, headers: false) do |row|
      csv_content.push(row)
    end

    csv_content
  end

  def get_data(search_term)
    result = []
    formatted_search_term = search_term.gsub(' ', '+')
    url = "https://www.google.com/search?q=#{formatted_search_term}&hl=en"

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
    unparsed_page = HTTParty.get(url, headers: headers.sample,

                                      follow_redirects: true)
    parsed_page = Nokogiri::HTML(unparsed_page.body)

    sponsored_spans = parsed_page.css('span').select { |span| span.text.include?('Sponsored') }.count
    advertisers_count = sponsored_spans

    result_stats = parsed_page.css('#result-stats').text
    links = parsed_page.css('a').count
    html_content = parsed_page.to_html.to_s.gsub(/<script.*?<\/script>/m, '')
    result.push(advertisers_count, result_stats, links, html_content)
    sleep(4)
    result
  end

  def validate_csv_file
    unless valid_csv_file?
      flash[:alert] = 'Invalid file type. Please upload a CSV file.'
      redirect_to new_scrap_path
    end
  end

  def valid_csv_file?
    allowed_extensions = %w[csv]
    extension = params[:scrap][:csv_file_name].original_filename.split('.').last.downcase
    allowed_extensions.include?(extension)
  end

  def scrap_params
    params.require(:scrap).permit(:csv_file_name)
  end
end
