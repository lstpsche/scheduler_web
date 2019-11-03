class RemoveAuthorIdFromSchedulesAndAddItToScheduleUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :author_id
    add_column :schedule_users, :author, :boolean, null: false, default: false
  end
end
