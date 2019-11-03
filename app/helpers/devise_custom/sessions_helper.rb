# frozen_string_literal: true

module DeviseCustom
  module SessionsHelper
    def after_sign_in_action
      if current_user.one_time_password? && current_user.logged_in_via_otp?
        redirect_to edit_user_registration_path
      else
        respond_with resource, location: after_sign_in_path_for(resource)
      end
    end

    def check_user_validity
      # HACK: to make devise show error message
      warden.authenticate!(auth_options) unless cur_user.present?
    end

    def otp_match?(password)
      encrypted_pass = hash_password(password, cur_user.username)

      cur_user.encrypted_otp == encrypted_pass
    end

    def logged_in_user(params)
      otp_match?(params[:password]) ? cur_user : nil
    end
  end
end
