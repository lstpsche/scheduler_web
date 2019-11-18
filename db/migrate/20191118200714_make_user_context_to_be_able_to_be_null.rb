class MakeUserContextToBeAbleToBeNull < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :context, :jsonb, null: true
  end
end
