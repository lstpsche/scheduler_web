# frozen_string_literal: true

class EventsController < ApplicationController
  def create
    @schedule = Schedule.find_by(id: params[:schedule_id])
    @event = @schedule.events.new(event_params)

    if @event.save
      redirect_to schedule_path(@schedule)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def event_params
    time = permitted_params['time(4i)'] + ':' + permitted_params['time(5i)']
    weekday = permitted_params[:weekday].downcase
    permitted_params.merge(time: time, weekday: weekday).reject { |key, _val| key.match(/^time\(/) }
  end

  def permitted_params
    params.require(:event).permit(:weekday, :time, :info, :additional_info)
  end
end
