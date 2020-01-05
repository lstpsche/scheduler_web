# frozen_string_literal: true

class BotLoginController < ApplicationController
  include BotLoginHelper

  respond_to :json

  def login
    return head :no_content if user_signed_in?

    user = find_or_create_user(user_params)

    sign_in(user)
    flash[:notice] = I18n.t('devise.sessions.signed_in')
  rescue StandardError
    head :bad_request
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :first_name, :last_name, :avatar_url)
  end
end
