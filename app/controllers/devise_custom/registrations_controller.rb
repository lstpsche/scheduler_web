# frozen_string_literal: true

module DeviseCustom
  class RegistrationsController < Devise::RegistrationsController
    after_action :set_one_time_password_false, only: :update

    def update
      if current_user.one_time_password
        # check if token valid
        binding.pry
      else
        super
      end
    end

    private

    def set_one_time_password_false
      current_user.update(one_time_password: false)
    end
  end
end
