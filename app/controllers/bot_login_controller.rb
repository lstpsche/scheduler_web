# frozen_string_literal: true

class BotLoginController < ApplicationController
  include BotLoginHelper

  respond_to :json

  def login
    return head :no_content if user_signed_in?

    return false unless sign_in(user)

    update_tg_avatar_url
    true
  rescue StandardError
    head :bad_request
  end

  private

  def user
    @user ||= User.find_by(id: user_params[:id]) || create_user_with(user_params)
  end

  def update_tg_avatar_url
    return if user.tg_avatar_url == user_params[:avatar_url]

    user.update(tg_avatar_url: user_params[:avatar_url])
  end

  def user_params
    params.require(:user).permit(:id, :username, :first_name, :last_name, :avatar_url)
  end

  def create_user_with(user_params)
    new_user = create_user(user_params)
    new_user.attach_avatar_from_url(url: user_params[:avatar_url])

    new_user
  end

  def create_user(user_params)
    User.create(
      id: user_params[:id],
      username: user_params[:username],
      first_name: user_params[:first_name],
      last_name: user_params[:last_name],
      tg_avatar_url: user_params[:avatar_url]
    )
  end
end
