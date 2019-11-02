# frozen_string_literal: true

class ChangeAuthorFieldAndAddClonedFieldToSchedule < ActiveRecord::Migration[5.2]
  def change
    change_column :schedules, :author_id, :integer, null: true
    add_column :schedules, :cloned, :boolean, null: false, default: false
  end
end
