# frozen_string_literal: true

module ApplicationHelper
  private

  def hash_password(password, username)
    Digest::SHA256.hexdigest(password + username + ENV['SALT'])
  end

  def redirect_if_otp
    return unless current_user

    redirect_to edit_user_registration_path if current_user.logged_in_via?('otp')
  end

  def render_404_error
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
    end
  end
end
