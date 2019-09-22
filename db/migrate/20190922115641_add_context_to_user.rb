# frozen_string_literal: true

class AddContextToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :context, :jsonb, null: false, default: '{}'
  end
end
