class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.integer :addWords
      t.integer :links
      t.integer :results
      t.integer :time

      t.timestamps
    end
  end
end
