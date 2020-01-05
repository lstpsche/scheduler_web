# frozen_string_literal: true

module BotLoginHelper
  def find_or_create_user(user_params)
    User.find_by(id: user_params[:id]).presence || create_user_with(user_params)
  end

  def create_user_with(user_params)
    user = create_user(user_params)
    user.attach_avatar_from_url(url: user_params[:avatar_url])

    user
  end

  private

  def create_user(user_params)
    User.create(
      id: user_params[:id],
      username: user_params[:username],
      first_name: user_params[:first_name],
      last_name: user_params[:last_name]
    )
  end
end
