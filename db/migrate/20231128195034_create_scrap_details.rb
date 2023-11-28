class CreateScrapDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :scrap_details do |t|
      t.integer :addWords
      t.string :stats
      t.integer :links
      t.string :html_cache

      t.timestamps
    end
  end
end
