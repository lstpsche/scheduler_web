class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, default: ''
      t.string :last_name, null: false, default: ''
      t.string :username, unique: true, null: false
      t.string :language_code, null: false, default: 'en'

      t.timestamps
    end
  end
end
