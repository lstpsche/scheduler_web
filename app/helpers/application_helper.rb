# frozen_string_literal: true

module ApplicationHelper
  def controller_action
    controller_name + '#' + action_name
  end

  def user_avatar(user: current_user, size: 25)
    return unless user&.avatar&.attached?

    image_tag(
      user.avatar.variant(resize: "#{size}x#{size}"),
      id: 'navbar-user-avatar',
      class: 'rounded-circle user-avatar'
    )
  end
end
