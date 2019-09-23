# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  serialize :context, HashSerializer
  store_accessor :context, :last_message, :replace_last_message, :return_to
  has_many :schedule_users
  has_many :schedules, through: :schedule_users

  alias :replace_last_message? :replace_last_message

  def last_message_id
    last_message[:result][:message_id]
  end
end
