# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper

  private

  def render_404_error
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end

  def current_path
    Rails.application.routes.recognize_path(request.url)
  end

  def clear_url_params
    return unless request.query_parameters.present?

    redirect_to current_path
  end
end
