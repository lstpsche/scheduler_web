# frozen_string_literal: true

module DeviseCustom
  class RegistrationsController < Devise::RegistrationsController
    include DeviseCustom::RegistrationsHelper

    before_action :render_404_error, only: %i[new edit]
  end
end
