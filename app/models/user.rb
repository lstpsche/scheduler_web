# frozen_string_literal: true

class User < ApplicationRecord
  serialize :context, HashSerializer
  store_accessor :context, :last_message, :replace_last_message, :return_to
  has_many :schedule_users
  has_many :schedules, through: :schedule_users
end
