# frozen_string_literal: true

class Event < ApplicationRecord
  validates_with Validators::Base, fields: %i[time weekday info]
end
