# frozen_string_literal: true

module Api
  module V1
    class BotLoginController < Api::V1::ApplicationController
      def login
        return head :no_content if user_signed_in? || !sign_in(user)

        head :ok
      rescue StandardError
        head :bad_request
      end

      private

      def user
        @user ||= update_user_with(user_params) || create_user_with(user_params)
      end

      def user_params
        params.require(:user).permit(:id, :username, :first_name, :last_name, :avatar_url).tap do |prms|
          prms[:tg_avatar_url] = prms.delete(:avatar_url)
        end
      end

      def update_user_with(update_params)
        User.find_by(id: update_params.delete(:id)).tap do |user|
          user.update(update_params)
          user.attach_avatar_from_url(url: update_params[:tg_avatar_url])
        end
      end

      def create_user_with(create_params)
        User.create(create_params).tap do |user|
          user.attach_avatar_from_url(url: create_params[:tg_avatar_url])
        end
      end
    end
  end
end
