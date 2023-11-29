class AddQueryToScrapDetail < ActiveRecord::Migration[7.0]
  def change
    add_column :scrap_details, :query, :string
  end
end
