class Scrap < ApplicationRecord
  mount_uploader :csv_file_name, CsvFileUploader
  belongs_to :user
  has_many :scrap_details, dependent: :destroy

  validates :csv_file_name, presence: { message: 'Please select a CSV file.' }

  def not_over_100_queries
    if Scrap.count > 100
      errors.add(:base, "Too many queries, please delete some")
    end
  end
end
