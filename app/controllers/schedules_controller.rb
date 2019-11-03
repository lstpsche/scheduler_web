# frozen_string_literal: true

class SchedulesController < ApplicationController
  before_action :new_schedule, only: %i[new create]
  helper_method :schedule, :schedules
  before_action :authenticate_user!

  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    if schedule.save
      redirect_to schedules_path
    else
      render :new
    end
  end

  def update
    if schedule.update(schedule_params)
      redirect_to schedule
    else
      redirect_back(fallback_location: edit_schedule_path(schedule))
    end
  end

  def destroy
    schedule.destroy

    redirect_to schedules_path
  end

  private

  def new_schedule
    @schedule = Schedule.new(schedule_params)
  end

  def schedule
    @schedule ||= Schedule.find_by(id: params[:id])
  end

  def schedules
    @schedules ||= Schedule.all.order('created_at ASC')
  end

  def schedule_params
    return nil unless params[:schedule]

    params.require(:schedule).permit(:name, :additional_info)
  end
end
