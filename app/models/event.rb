# frozen_string_literal: true

class Event < ApplicationRecord
  validates_with Validators::EventValidator, fields: %i[time]
end
