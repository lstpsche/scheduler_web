# frozen_stringX_literal: true

class MakeWeekdayAnEnum < ActiveRecord::Migration[5.2]
  def up
    remove_column :events, :weekday

    execute <<-SQL
      CREATE TYPE event_weekday AS ENUM ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday');
    SQL

    add_column :events, :weekday, :event_weekday, null: false
  end

  def down
    remove_column :events, :weekday

    execute <<-SQL
      DROP TYPE event_weekday;
    SQL

    add_column :events, :weekday, :string
  end
end
