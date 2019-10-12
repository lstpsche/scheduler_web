# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  acts_as_token_authenticatable

  validates :username, uniqueness: true

  serialize :context, HashSerializer
  store_accessor :context, :last_message, :replace_last_message, :return_to
  has_one :student_settings
  has_many :schedule_users
  has_many :schedules, through: :schedule_users

  alias :replace_last_message? :replace_last_message

  def last_message_id
    last_message[:result][:message_id]
  end

  def email_changed?
    false
  end

  def first_sign_in?
    sign_in_count == 1
  end
end
