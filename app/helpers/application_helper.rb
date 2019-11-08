# frozen_string_literal: true

module ApplicationHelper
  private

  def generate_auth_token
    SecureRandom.urlsafe_base64
  end

  def hash_password(password, username)
    Digest::SHA256.hexdigest(password + username + ENV['SALT'])
  end

  def redirect_if_otp
    return unless current_user

    redirect_to edit_user_registration_path if current_user.logged_in_via?('otp')
  end

  def renew_auth_token!
    current_user.update(authentication_token: generate_auth_token)
  end
end
