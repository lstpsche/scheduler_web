# frozen_string_literal: true

class BotConnectionsController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback: :none

  def set_one_time_password
    user.one_time_password = generate_one_time_password
    user.first_sign_in? = true
    user.save
  end

  def generate_secure_token
  end

  private

  def user
    @user ||= User.find_by(id: user_params[:id])
  end

  def generate_one_time_password
    SecureRandom.hex(3)
  end

  def generate_token
    SecureRandom.base64(100)
  end

  def secure_token
    params.require(:bot).permit(:secure_token)[:secure_token]
  end

  def user_params
    params.require(:user).permit(:id, :password)
  end
end
