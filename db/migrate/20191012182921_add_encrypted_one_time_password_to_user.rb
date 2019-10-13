# frozen_string_literal: true

class AddEncryptedOneTimePasswordToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :encrypted_otp, :string, null: false, default: ''
  end
end
