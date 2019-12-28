# frozen_string_literal: true

module ApplicationHelper
  private

  def render_404_error
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end

  def controller_action
    controller_name + '#' + action_name
  end
end
