# frozen_string_literal: true

module BotLoginHelper
  def find_or_create_user(user_params)
    User.find_by(id: user_params[:id]).presence || create_user_with(user_params)
  end

  def create_user_with(user)
    User.create(
      id: user[:id],
      username: user[:username],
      first_name: user[:first_name],
      last_name: user[:last_name]
    )
  end
end
