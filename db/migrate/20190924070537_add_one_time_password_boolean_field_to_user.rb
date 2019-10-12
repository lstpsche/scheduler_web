# frozen_string_literal: true

class AddOneTimePasswordBooleanFieldToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :one_time_password, :boolean, null: false, default: false
  end
end
