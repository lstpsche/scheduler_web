# frozen_string_literal: true

class AddCustomFieldToSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :custom, :boolean, null: false, default: false
    add_column :schedules, :customed_by, :integer
  end
end
