# frozen_string_literal: true

module BotLoginHelper
  def create_user_with(user)
    User.create(
      id: user[:id],
      username: user[:username],
      first_name: user[:first_name],
      last_name: user[:last_name]
    )
  end
end
