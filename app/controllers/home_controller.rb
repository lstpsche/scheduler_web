# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :redirect_to_schedules, only: %i(index)

  def index; end

  private

  def redirect_to_schedules
    redirect_to schedules_path if current_user
  end
end
