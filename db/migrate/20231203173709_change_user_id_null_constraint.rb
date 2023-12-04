class ChangeUserIdNullConstraint < ActiveRecord::Migration[7.0]
  def change
    change_column_null :scraps, :user_id, true
  end
end
