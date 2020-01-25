class AddTgAvatarUrlToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tg_avatar_url, :string, null: false, default: ''
  end
end
