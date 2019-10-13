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

  # it's needed to escape devise's extreme depending on emails
  def email_changed?
    false
  end

  def encrypted_otp
    otp_fresh? ? super : nil
  end

  def logged_in_via_otp?
    logged_in_via == 'otp'
  end

  def logged_in_via_pass?
    logged_in_via == 'pass'
  end

  def one_time_password?
    otp_fresh? ? one_time_password : false
  end

  # One-Time Password can be used for 1 day (24 hours) only
  def otp_fresh?
    (Time.current - otp_generated_at) / 1.day < 1
  end
end
