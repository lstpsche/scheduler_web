# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!

  def create
    if schedule.events.create(event_params)
      redirect_to schedule_path(schedule)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    event.destroy

    redirect_to schedule_path(schedule)
  end

  private

  def schedule
    @schedule ||= Schedule.find_by(id: params[:schedule_id])
  end

  def event
    @event ||= Event.find_by(id: params[:id])
  end

  def event_params
    remove_redundant_times(
      permitted_params.merge(time: time, weekday: weekday)
    )
  end

  def time
    permitted_params[:time]
  end

  def weekday
    permitted_params[:weekday].downcase
  end

  def remove_redundant_times(raw_hash)
    raw_hash.reject { |key, _val| key.match(/^time\(/) }
  end

  def permitted_params
    params.require(:event).permit(:weekday, :time, :info, :additional_info)
  end
end
