class RemoveOtpFieldsFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :one_time_password
    remove_column :users, :encrypted_otp
    remove_column :users, :logged_in_via
    remove_column :users, :otp_generated_at
  end
end
