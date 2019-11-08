# frozen_string_literal: true

module DeviseCustom
  module RegistrationsHelper
    def after_update_path_for(resource)
      resource.update_otp_after_pass_set

      schedules_path
    end

    def set_flash_message_for_update(resource, email)
      if resource.logged_in_via?('otp')
        flash[:notice] = I18n.t('devise.registrations.password_created')
      else
        super
      end
    end

    def update_resource(resource, update_params)
      resource.update_pass_after_otp_log_in(update_params) || super
    end
  end
end
