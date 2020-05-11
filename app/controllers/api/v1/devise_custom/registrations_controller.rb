# frozen_string_literal: true

module Api
  module V1
    module DeviseCustom
      class RegistrationsController < Devise::RegistrationsController
        # TODO: remove this before_action and write better routes instead

        private

        def after_update_path_for(_resource)
          schedules_path
        end
      end
    end
  end
end
