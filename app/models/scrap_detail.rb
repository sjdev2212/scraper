class ScrapDetail < ApplicationRecord
  belongs_to :scrap
  validates :addWords, presence: true
  validates :stats, presence: true
  validates :links, presence: true
  validates :html_cache, presence: true
  validates :scrap_id, presence: true
  validates :query, presence: true
end
