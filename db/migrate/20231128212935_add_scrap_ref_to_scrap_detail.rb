class AddScrapRefToScrapDetail < ActiveRecord::Migration[7.0]
  def change
    add_reference :scrap_details, :scrap, null: false, foreign_key: true
  end
end
