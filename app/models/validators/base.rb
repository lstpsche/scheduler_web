# frozen_string_literal: true

module Validators
  class Base < ActiveModel::Validator
    VALIDATORS = {
      'event' => Validators::EventValidator
    }.freeze

    def validate(record)
      key = record.class.to_s.underscore

      VALIDATORS[key].new(options[:fields]).validate(record)
    end
  end
end
