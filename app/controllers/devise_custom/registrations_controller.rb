# frozen_string_literal: true

module DeviseCustom
  class RegistrationsController < Devise::RegistrationsController
    # TODO: remove this before_action and write better routes instead
    before_action :render_404_error, only: %i[new edit]

    private

    def after_update_path_for(_resource)
      schedules_path
    end
  end
end
