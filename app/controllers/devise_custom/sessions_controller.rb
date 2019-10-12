# frozen_string_literal: true

module DeviseCustom
  class SessionsController < Devise::SessionsController
    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?

      respond_with resource, location: after_sign_in_location
    end

    private

    def after_sign_in_location
      current_user.first_sign_in? ? edit_user_registration_path : after_sign_in_path_for(resource)
    end
  end
end
