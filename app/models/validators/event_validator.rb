# frozen_string_literal: true

module Validators
  class EventValidator < Base
    attr_reader :fields, :event

    def initialize(fields)
      @fields = fields
      @errors = []
    end

    def validate(event)
      @event = event
      fields.each { |field| send("validate_#{field}") }

      if @errors.any?(&:present?)
        @errors.each { |error| event.errors[:base] << error }
      end
    end

    private

    def validate_info
      @errors << 'Event should have a name.' unless event.info.present?
    end

    def validate_time
      hours, minutes = event.time.split(':', 2).map(&:to_i)
      @errors << 'Hours out of range.' if hours > 23 || hours < 0
      @errors << 'Minutes out of range.' if minutes > 59 || minutes < 0
    rescue => error
      @errors << error.to_s
    end

    def validate_weekday
      @errors << 'Weekday should be a valid weekday name.' unless I18n.t('weekdays').values.include? event.weekday
    end
  end
end
