# frozen_string_literal: true

module ApplicationHelper
  def hash_password(password, username)
    Digest::SHA256.hexdigest(password + username + ENV['SALT'])
  end

  def redirect_if_otp
    return unless current_user

    redirect_to edit_user_registration_path if current_user.logged_in_via_otp?
  end
end
