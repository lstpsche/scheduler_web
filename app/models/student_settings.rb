# frozen_string_literal: true

class StudentSettings < ApplicationRecord
  belongs_to :user

  def options_list
    %i[university faculty course department group]
  end
end
