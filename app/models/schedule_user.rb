# frozen_string_literal: true

class ScheduleUser < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  after_create do |s_u|
    unless ScheduleUser.find_by(schedule_id: s_u.schedule.id, author: true).present?
      s_u.update(author: true)
      fill_student_settings(s_u) if s_u.schedule.for_student
    end
  end

  private

  # TODO: check if it's working fine
  def fill_student_settings(s_u)
    student_settings = s_u.user.student_settings

    student_settings.options_list.each { |option_name| update_student_option(s_u, option_name) }
  end

  def update_student_option(s_u, option_name)
    s_u.schedule.update(option_name => s_u.user.student_settings.try(option_name))
  end
end
