# frozen_string_literal: true

module Api
  module V1
    class AuthController < Api::V1::ApplicationController
      def signed_in
        if user_signed_in?
          render json: { signed_in: true, user: serialized_current_user }.to_json
        else
          render json: { signed_in: false }.to_json
        end
      end
    end
  end
end
