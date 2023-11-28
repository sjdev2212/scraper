# Controller responsible for handling CRUD operations for Scrap objects.
# frozen_string_literal: true
class ScrapsController < ApplicationController

  require 'csv'

  def new
    @scrap = Scrap.new
  end

  def create
    @scrap = Scrap.new(scrap_params)
    if @scrap.present? && @scrap.csv_file_name.present?
      file_path = @scrap.csv_file_name.path
      @csv_content = process_csv_file(file_path)
       if @csv_content.count > 100
          flash[:alert] = 'File should not contain more than 100 queries.'
          render :new
        else
          @scrap.save 
          redirect_to process_csv_scrap_path(@scrap.id), notice: 'CSV file uploaded successfully.'
        end

      end
    end

   def index
    @scraps = Scrap.all
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

  def scrap_params
    params.fetch(:scrap, {}).permit(:csv_file_name)
  end
end
