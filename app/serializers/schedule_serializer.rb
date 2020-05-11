# frozen_string_literal: true

class ScheduleSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :additional_info
end
