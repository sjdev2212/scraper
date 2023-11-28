class CreateScraps < ActiveRecord::Migration[7.0]
  def change
    create_table :scraps do |t|
      t.string :csv_file_name

      t.timestamps
    end
  end
end
