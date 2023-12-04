class ChangeScrapIdNullConstraint < ActiveRecord::Migration[7.0]
  def change
    change_column_null :scrap_details, :scrap_id, true
  end
end
