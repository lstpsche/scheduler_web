# frozen_string_literal: true

module Api
  module V1
    module Admin
      class UsersController < Api::V1::ApplicationController
        def index
          render json: { users: serialized_users }.to_json
        end

        private

        def users
          @users ||= User.all
        end

        def serialized_users
          users.map { |user|
            UserSerializer.new(user).serializable_hash
          }
        end
      end
    end
  end
end
