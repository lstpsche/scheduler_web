# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ::ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def serialized_current_user
        UserSerializer.new(current_user).serializable_hash
      end

      def serialize_schedule(schedule)
        ScheduleSerializer.new(schedule).serializable_hash
      end

      def serialize_event(event)
        EventSerializer.new(event).serializable_hash
      end

      private

      def record_not_found
        render json: { error: I18n.t('errors.record_not_found') }, status: :bad_request
      end
    end
  end
end
