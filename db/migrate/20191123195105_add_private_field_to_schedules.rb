class AddPrivateFieldToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :private, :boolean, null: false, default: true
  end
end
