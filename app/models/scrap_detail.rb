class ScrapDetail < ApplicationRecord
  belongs_to :scrap
  validates :addWords, :stats, :links, presence: true
end
