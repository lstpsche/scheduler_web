# frozen_string_literal: true

module DeviseCustom
  class PasswordsController < Devise::PasswordsController
    include DeviseCustom::PasswordsHelper
    skip_before_action :verify_authenticity_token, only: :create
    before_action :check_validity_token_match, only: :create

    def create
      if user.otp_fresh?
        user.errors.add(:base, I18n.t('devise.sessions.otp_is_fresh'))
        render :new
      else
        generate_password
        set_one_time_password

        if user.save
          send_one_time_password
          redirect_to new_user_session_path
        else
          render :new
        end
      end
    end

    private

    def check_validity_token_match
      head :unprocessable_entity unless validity_token_match?
    end

    def user
      @user ||= User.find_by(username: user_params[:username])
    end

    def user_params
      params.require(:user).permit(:username)
    end
  end
end
