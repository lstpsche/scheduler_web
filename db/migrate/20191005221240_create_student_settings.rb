# frozen_string_literal: true

class CreateStudentSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :student_settings do |t|
      t.belongs_to :user
      t.string :university, null: false
      t.string :faculty, null: false
      t.string :course, null: false
      t.string :department
      t.string :group

      t.timestamps
    end
  end
end
