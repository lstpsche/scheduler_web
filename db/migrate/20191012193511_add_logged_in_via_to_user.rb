class AddLoggedInViaToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :logged_in_via, :string
  end
end
