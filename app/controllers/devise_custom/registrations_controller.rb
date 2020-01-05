# frozen_string_literal: true

module DeviseCustom
  class RegistrationsController < Devise::RegistrationsController
    include DeviseCustom::RegistrationsHelper

    before_action :render_404_error, only: %i[new edit]

    private

    def after_update_path_for(_resource)
      schedules_path
    end
  end
end
