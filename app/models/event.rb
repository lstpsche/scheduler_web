# frozen_string_literal: true

class Event < ApplicationRecord
  validates :weekday, :time, :info, presence: true
  validates_with Validators::Base, fields: %i[weekday time info]
end
