# frozen_string_literal: true

class EventSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :weekday, :time, :info, :additional_info, :schedule_id
end
