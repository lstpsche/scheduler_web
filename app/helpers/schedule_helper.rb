# frozen_string_literal: true

module ScheduleHelper
  def check_schedule_id
    id = params[:id]

    render_404_error unless id.to_i.to_s == id
  end
end
