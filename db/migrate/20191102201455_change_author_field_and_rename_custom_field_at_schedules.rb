# frozen_string_literal: true

class ChangeAuthorFieldAndRenameCustomFieldAtSchedules < ActiveRecord::Migration[5.2]
  def up
    change_column :schedules, :author_id, :integer, null: true

    remove_column :schedules, :custom
    add_column :schedules, :customed, :boolean, null: false, default: false
  end

  def down
    change_column :schedules, :author_id, :integer, null: false
  end
end
