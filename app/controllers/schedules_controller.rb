# frozen_string_literal: true

class SchedulesController < ApplicationController
  include TokenAuthenticatable
  include SchedulesHelper

  before_action :authenticate_user!
  before_action :clear_url_params, only: %i[new]
  before_action :new_schedule, only: %i[new create]
  before_action :check_schedule_id, only: %i[show]
  helper_method :schedule, :schedules, :new_schedule, :paginated_schedules

  def index; end

  def show; end

  def new; end

  def create
    if schedule.save_new(current_user)
      flash[:notice] = I18n.t('schedules.notice.created')
      redirect_to action: :index, page: paginated_schedules.total_pages
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if schedule.update(schedule_params)
      redirect_to schedules_path, notice: I18n.t('schedules.notice.updated')
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
    @schedules ||= Schedule.for_user(current_user).order('created_at ASC')
  end

  def paginated_schedules
    @paginated_schedules ||= schedules.paginate(page: params[:page], per_page: 5)
  end

  def schedule_params
    return nil unless params.fetch(:schedule, false)

    params.require(:schedule).permit(:name, :additional_info)
  end

  def check_schedule_id
    id = params[:id]

    render_404_error unless id.to_i.to_s == id
  end
end
