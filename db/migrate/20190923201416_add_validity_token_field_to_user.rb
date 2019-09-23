class AddValidityTokenFieldToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :validity_token, :string, null: true, default: nil
  end
end
