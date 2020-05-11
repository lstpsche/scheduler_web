# frozen_string_literal: true

module Api
  module V1
    module DeviseCustom
      class SessionsController < Devise::SessionsController
        # DELETE /sign_out
        def destroy
          super
          flash.delete(:notice)
        end

        private

        # Check if there is no signed in user before doing the sign out.
        #
        # If there is no signed in user, it will set the flash message and redirect
        # to the after_sign_out path.
        def verify_signed_out_user
          super
          flash.delete(:notice)
        end

        # Used in before_action for [:new, :create]
        # Sets 'already_authenticated' alert if user is already authenticated
        def require_no_authentication
          super
          flash.delete(:alert)
        end
      end
    end
  end
end
