class RemoveClonedFieldFromSchedule < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :cloned
  end
end
