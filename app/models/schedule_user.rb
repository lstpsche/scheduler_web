# frozen_string_literal: true

class ScheduleUser < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  after_create do |s_u|
    unless ScheduleUser.find_by(schedule_id: s_u.schedule.id, author: true).present?
      set_author_true(s_u)
      fill_student_settings(s_u) if s_u.schedule.for_student
    end
  end

  private

  def set_author_true(s_u)
    s_u.update(author: true)
  end

  def fill_student_settings(s_u)
    student_settings = s_u.user.student_settings

    s_u.schedule.update(
      university: student_settings.university,
      faculty: student_settings.faculty,
      course: student_settings.course,
      department: student_settings.department,
      group: student_settings.group
    )
  end
end
