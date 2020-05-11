# frozen_string_literal: true

class Event < ApplicationRecord
  enum weekday: { monday: 'monday', tuesday: 'tuesday', wednesday: 'wednesday', thursday: 'thursday',
                  friday: 'friday', saturday: 'saturday', sunday: 'sunday' }, _prefix: true

  validates :weekday, :time, :info, presence: true
  validates_with Validators::EventValidator, fields: %i[time]

  def weekday=(new_weekday)
    super(new_weekday.downcase) if new_weekday.present?
  end
end
