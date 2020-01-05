# frozen_string_literal: true

module ApplicationHelper
  private

  def render_404_error
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end

  def controller_action
    controller_name + '#' + action_name
  end

  def current_path
    Rails.application.routes.recognize_path(request.url)
  end

  def clear_url_params
    return unless request.query_parameters.present?

    redirect_to current_path
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
