class AddBotsFirstStartFlagToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :global_bot_first_start, :boolean, null: false, default: true
    add_column :users, :students_bot_first_start, :boolean, null: false, default: true
  end
end
