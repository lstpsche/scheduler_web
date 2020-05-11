# frozen_string_literal: true

module Validators
  class EventValidator < ActiveModel::Validator
    attr_reader :fields, :event

    def initialize(*args)
      super
      @fields = options[:fields]
      @errors = []
    end

    def validate(event)
      @event = event
      fields.each { |field| send("validate_#{field}") }

      @errors.each { |error| event.errors[:base] << error } if @errors.any?(&:present?)
    end

    private

    def validate_time
      hours, minutes = hours_and_minutes
      check_time_valid(hours, minutes)
    rescue StandardError => error
      @errors << error.to_s
    end

    def hours_and_minutes
      event.time.split(':', 2).map(&:to_i)
    end

    def check_time_valid(hours, minutes)
      @errors << 'Hours out of range.' if hours > 23 || hours.negative?
      @errors << 'Minutes out of range.' if minutes > 59 || minutes.negative?
    end
  end
end
