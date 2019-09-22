# frozen_string_literal: true

module Validators
  class EventValidator < ActiveModel::Validator
    def validate(record)
      @errors = []
      validate_time

      if @errors.any?(&:present?)
        @errors.each { |error| record.errors[:base] << error }
        record
      end
    end

    private

    def validate_time
      time = options[:fields][:time]
      Time.parse(time)
    rescue => error
      @errors << error
    end
  end
end
