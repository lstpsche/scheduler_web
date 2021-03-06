# frozen_string_literal: true

class Schedule < ApplicationRecord
  validates :name, presence: true

  has_many :schedule_users, dependent: :destroy
  has_many :users, through: :schedule_users
  has_many :events, dependent: :destroy

  scope :for_user, ->(user) { joins(:schedule_users).where('schedule_users.user_id = (?)', user) }

  def save_new(user)
    return false unless save

    ScheduleUser.create(schedule: self, user: user, author: true)
  end

  def events_by_weekday
    events = self.events

    I18n.t('weekdays').inject({}) do |result, (key, weekday)|
      result.merge(key => events_at_weekday(events, weekday))
    end.compact
  end

  def author
    schedule_users.find_by(author: true)&.user
  end

  def create_custom
    Schedule.create(attributes.merge(customed_new_attrs))
  end

  private

  def events_at_weekday(events, weekday)
    events.select { |event| event.weekday == weekday }.presence
  end

  def customed_new_attrs
    {
      id: nil,
      customed: true, customed_by: id,
      created_at: nil, updated_at: nil
    }
  end
end
