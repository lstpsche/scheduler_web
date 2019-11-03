class AddBotSecureTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bot_secure_token, :string, null: true, default: nil
  end
end
