class ChangeUserBotSecureTokenToBotRequestAuthToken < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :bot_secure_token
    add_column :users, :bot_request_auth_token, :string
  end
end
