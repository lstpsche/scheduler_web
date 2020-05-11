# frozen_string_literal: true

module Api
  module V1
    class SchedulesController < Api::V1::ApplicationController
      include TokenAuthenticatable

      before_action :authenticate_user!
      before_action :build_schedule, only: :create

      def index
        schedules = Schedule.for_user(current_user).order('created_at ASC').map do |schedule|
          serialize_schedule(schedule)
        end

        render json: { schedules: schedules }.to_json
      end

      def show
        serialized_events = schedule.events_order_by_time.map { |event| serialize_event(event) }

        render json: { events: serialized_events, schedule: serialize_schedule(schedule) }.to_json
      end

      def create
        if schedule.save_new(current_user)
          render json: { success: true, schedule: serialize_schedule(schedule) }.to_json
        else
          render json: { success: false, errors: schedule.errors.messages }.to_json
        end
      end

      def update
        if schedule.update(schedule_params)
          render json: { success: true, schedule: serialize_schedule(schedule) }.to_json
        else
          render json: { success: false, errors: schedule.errors.messages }.to_json
        end
      end

      def destroy
        # TODO: fill it
      end

      private

      def schedule
        @schedule ||= Schedule.find(params[:id])
      end

      def build_schedule
        @schedule = Schedule.new(schedule_params)
      end

      def schedule_params
        return nil unless params.fetch(:schedule, false)

        params.require(:schedule).permit(:name, :additional_info)
      end
    end
  end
end
