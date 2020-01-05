# frozen_string_literal: true

class SchedulesController < ApplicationController
  include TokenAuthenticatable
  include ScheduleHelper

  before_action :clear_url_params, only: %i[new]
  before_action :new_schedule, only: %i[new create]
  before_action :check_schedule_id, only: %i[show]
  before_action :authenticate_user!
  helper_method :schedule, :schedules, :new_schedule

  def index; end

  def show; end

  def new; end

  def create
    if schedule.save_new(current_user)
      redirect_to schedules_path, flash: { notice: I18n.t('schedules.notice.created') }
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if schedule.update(schedule_params)
      redirect_to schedules_path, flash: { notice: I18n.t('schedules.notice.updated') }
    else
      redirect_back(fallback_location: root_path)
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
    @schedules ||= Schedule.for_user(current_user).order('created_at ASC').paginate(page: params[:page], per_page: 5)
  end

  def schedule_params
    return nil unless params.fetch(:schedule, false)

    params.require(:schedule).permit(:name, :additional_info)
  end
end
