class ScrapDetail < ApplicationRecord
  belongs_to :scrap, dependent: :destroy

  

end
