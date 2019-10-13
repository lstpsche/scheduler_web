# frozen_string_literal: true

module DeviseCustom
  class SessionsController < Devise::SessionsController
    include DeviseCustom::SessionsHelper

    before_action :check_user_validity, only: :create
    skip_before_action :redirect_if_otp, only: :destroy

    def create
      if cur_user.one_time_password? && (otp_matched = otp_match?(permitted_params[:password]))
        self.resource = logged_in_user(permitted_params)
        cur_user.update(logged_in_via: 'otp') if resource
      end

      self.resource ||= warden.authenticate!(auth_options)
      cur_user.update(logged_in_via: 'pass') if resource && !otp_matched

      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?

      after_sign_in_action
    end

    private

    def cur_user
      @cur_user ||= User.find_by(username: permitted_params[:username])
    end

    def permitted_params
      params.require(:user).permit(:username, :password)
    end
  end
end
