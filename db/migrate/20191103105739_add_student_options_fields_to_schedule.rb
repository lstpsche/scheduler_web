# frozen_string_literal: true

class AddStudentOptionsFieldsToSchedule < ActiveRecord::Migration[5.2]
  def up
    change_table :schedules do |t|
      t.string :university, :faculty, :course, :department, :group
    end
  end

  def down
    remove_column :schedules, :university
    remove_column :schedules, :faculty
    remove_column :schedules, :course
    remove_column :schedules, :department
    remove_column :schedules, :group
  end
end
