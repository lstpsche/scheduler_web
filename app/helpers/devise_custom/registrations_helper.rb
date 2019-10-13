# frozen_string_literal: true

module DeviseCustom
  module RegistrationsHelper
    def after_update_path_for(resource)
      resource.update(one_time_password: false, encrypted_otp: '', logged_in_via: 'pass') if resource.logged_in_via_otp?

      schedules_path
    end

    def set_flash_message_for_update(resource, email)
      if resource.logged_in_via_otp?
        flash[:notice] = I18n.t('devise.registrations.password_created')
      else
        super
      end
    end

    def update_resource(resource, update_params)
      if resource.logged_in_via_otp?
        resource.update(
          password: update_params[:password],
          password_confirmation: update_params[:password_confirmation]
        )
      else
        super
      end
    end
  end
end
