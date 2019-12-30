# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :validate_user

    def index
      @users = User.all
    end

    private

    def validate_user
      render_404_error unless current_user&.admin?
    end
  end
end
