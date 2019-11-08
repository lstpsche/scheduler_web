# frozen_string_literal: true

module DeviseCustom
  class SessionsController < Devise::SessionsController
    include DeviseCustom::SessionsHelper

    before_action :check_user_validity, :login, only: :create
    skip_before_action :redirect_if_otp, only: :destroy

    def create
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?

      after_sign_in_action
    end

    private

    def login
      if cur_user.one_time_password? && otp_match?(permitted_params[:password])
        log_in_by_otp
      else
        log_in_by_pass
      end
    end

    def log_in_by_otp
      self.resource = logged_in_user(permitted_params)
      update_logged_in_via('otp')
    end

    def log_in_by_pass
      self.resource ||= warden.authenticate!(auth_options)
      update_logged_in_via('pass')
    end

    def cur_user
      @cur_user ||= User.find_by(username: permitted_params[:username])
    end

    def permitted_params
      params.require(:user).permit(:username, :password)
    end
  end
end
