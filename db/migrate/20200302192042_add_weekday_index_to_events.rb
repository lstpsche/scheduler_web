# frozen_string_literal: true

class AddWeekdayIndexToEvents < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :weekday
  end
end
