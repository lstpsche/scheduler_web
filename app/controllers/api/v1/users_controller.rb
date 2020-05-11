# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def show_attributes
        render json: { user: serialized_user }.to_json
      end

      def show_current
        render json: { user: serialized_current_user }.to_json
      end

      private

      # user_fields: ['username', 'language_code', 'admin']
      def serialized_user
        params[:user_fields].inject({}) do |hash, field|
          hash.merge(field => user.try(field))
        end
      end

      def user
        user_id = params[:id]

        @user ||= user_id == 'current' ? current_user : User.find(id)
      end
    end
  end
end
