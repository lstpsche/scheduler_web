# frozen_string_literal: true

class ScheduleUser < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
end
