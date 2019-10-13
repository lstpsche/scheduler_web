# frozen_string_literal: true

module DeviseCustom
  class PasswordsController < Devise::PasswordsController
    include DeviseCustom::PasswordsHelper

    def create
      unless user.otp_fresh?
        generate_password
        set_one_time_password

        if user.save
          send_one_time_password
          redirect_to new_user_session_path
        else
          render :new
        end
      else
        user.errors.add(:base, I18n.t('devise.sessions.otp_is_fresh'))
        render :new
      end
    end

    private

    def user
      @user ||= User.find_by(username: user_params[:username])
    end

    def user_params
      params.require(:user).permit(:username)
    end
  end
end
