# frozen_string_literal: true

module DeviseCustom
  class RegistrationsController < Devise::RegistrationsController
    include DeviseCustom::RegistrationsHelper

    skip_before_action :redirect_if_otp, only: %i[edit update]
  end
end
