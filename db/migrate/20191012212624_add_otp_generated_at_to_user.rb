class AddOtpGeneratedAtToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :otp_generated_at, :datetime, null: false, default: 1.day.ago
  end
end
