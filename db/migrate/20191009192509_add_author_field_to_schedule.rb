# frozen_string_literal: true

class AddAuthorFieldToSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :author_id, :integer, null: false
  end
end
