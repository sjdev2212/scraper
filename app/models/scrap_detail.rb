class ScrapDetail < ApplicationRecord
  belongs_to :scrap
  validates :addWords, :stats, :links, :html_cache, presence: true
end
