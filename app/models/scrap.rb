class Scrap < ApplicationRecord
  mount_uploader :csv_file_name, CsvFileUploader
  belongs_to :user
  has_many :scrap_details, dependent: :destroy

validates :csv_file_name, presence: true
validates :user_id, presence: true

end
