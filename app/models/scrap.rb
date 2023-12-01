class Scrap < ApplicationRecord
  mount_uploader :csv_file_name, CsvFileUploader
  belongs_to :user
  has_many :scrap_details, dependent: :destroy

  validates :csv_file_name, presence: true
  validates :user_id, presence: true
  validate :validate_unique_file_name


  # other model code...

  private



  def validate_unique_file_name
    return unless csv_file_name.cached?

    if Scrap.exists?(csv_file_name: csv_file_name.file.original_filename)
      errors.add(:csv_file_name, 'file name already exists in the database')
    end
  end
end
