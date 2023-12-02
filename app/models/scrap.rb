class Scrap < ApplicationRecord
  mount_uploader :csv_file_name, CsvFileUploader
  belongs_to :user
  has_many :scrap_details, dependent: :destroy

  validates :csv_file_name, presence: true
  validates :user_id, presence: true
  validate :validate_unique_file_name

  private



  def validate_unique_file_name
    return unless csv_file_name.cached?

    existing_scrap = user.scraps.find_by(csv_file_name: csv_file_name.file.original_filename)
    if existing_scrap && existing_scrap != self
      errors.add(:csv_file_name, 'file name already exists in the database')
    end
  end
end
