class AddForStudentFieldToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :for_student, :boolean, null: false, default: false
  end
end
