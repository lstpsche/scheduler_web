# frozen_string_literal: true

module DeviseCustom
  class PasswordsController < Devise::PasswordsController
    skip_before_action :verify_authenticity_token, only: %i[create]
    before_action :verify_validity_token, only: %i[create]

    def create
      user.password = user.password_confirmation = user_params[:password]
      user.one_time_password = true

      if user.save
        head :ok
      else
        head :unprocessable_entity
      end
    end

    def edit
      binding.pry
      super
    end

    private

    # TODO: rename validity_token to transaction_security_token
    def verify_validity_token
      validity_token = user&.validity_token
      user.update(validity_token: nil)

      request.headers[:HTTP_VALIDITY_TOKEN] == validity_token
    end

    def user
      @user ||= User.find_by(id: user_params[:id], username: user_params[:username])
    end

    def user_params
      params.require(:user).permit(:id, :username, :password)
    end
  end
end
