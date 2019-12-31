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

  def clear_get_params
    return unless request.query_parameters.present?

    redirect_to current_path
  end
end
