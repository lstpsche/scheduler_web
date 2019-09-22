# frozen_string_literal: true

class Schedule < ApplicationRecord
  validates :name, presence: true

  has_many :schedule_users, dependent: :destroy
  has_many :users, through: :schedule_users
  has_many :events, dependent: :destroy

  def events_by_weekday
    {
      monday: events.where(weekday: 'monday'),
      tuesday: events.where(weekday: 'tuesday')
    }
  end
end
