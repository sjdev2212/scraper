class AddUserRefToScrap < ActiveRecord::Migration[7.0]
  def change
    add_reference :scraps, :user, null: false, foreign_key: true
  end
end
