# frozen_string_literal: true

module DeviseCustom
  module RegistrationsHelper
    def after_update_path_for(resource)
      schedules_path
    end
  end
end
