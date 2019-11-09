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

  def author
    schedule_users.find_by(author: true)&.user
  end

  def create_custom
    Schedule.create(attributes.merge(customed_new_attrs))
  end

  private

  def customed_new_attrs
    {
      id: new_uniq_id,
      cloned: true,
      customed: true,
      customed_by: id,
      created_at: Time.current,
      updated_at: Time.current
    }
  end

  def new_uniq_id
    Schedule.pluck(:id).max.next
  end
end
