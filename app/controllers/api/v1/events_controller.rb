# frozen_string_literal: true

module Api
  module V1
    class EventsController < Api::V1::ApplicationController
      before_action :authenticate_user!
      before_action :build_event, only: :create

      def create
        if event.save
          render json: { success: true, event: serialize_event(event) }.to_json
        else
          render json: { success: false, errors: event.errors.messages }.to_json
        end
      end

      def update
        if event.update(event_params)
          render json: { success: true, event: serialize_event(event) }.to_json
        else
          render json: { success: false, errors: event.errors.messages }.to_json
        end
      end

      def destroy
        if event.destroy
          render json: { success: true }.to_json
        else
          render json: { success: false, errors: event.errors.messages }.to_json
        end
      end

      private

      def schedule
        @schedule ||= Schedule.find(params[:schedule_id])
      end

      def event
        @event ||= Event.find(params[:id])
      end

      def build_event
        @event = Event.new(event_params)
      end

      def event_params
        return nil unless params.fetch(:event, false)

        params.require(:event).permit(:time, :weekday, :info, :additional_info)
              .merge(params.permit(:schedule_id))
      end
    end
  end
end
