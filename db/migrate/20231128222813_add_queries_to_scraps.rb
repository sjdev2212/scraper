class AddQueriesToScraps < ActiveRecord::Migration[7.0]
  def change
    add_column :scraps, :queries, :text, array: true, default: [], using: "(string_to_array(queries, ','))"
  end
end
