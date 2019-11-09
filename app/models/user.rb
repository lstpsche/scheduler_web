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
  has_many :schedule_users, dependent: :destroy
  has_many :schedules, through: :schedule_users

  # it's needed to escape devise's extreme depending on emails
  def email_changed?
    false
  end

  def encrypted_otp
    otp_fresh? ? super : nil
  end

  def encrypted_otp=(value)
    super
    update(otp_generated_at: Time.current, one_time_password: true)
  end

  def logged_in_via?(method)
    logged_in_via == method
  end

  def one_time_password?
    otp_fresh? ? one_time_password : false
  end

  # One-Time Password can be used for 1 day (24 hours) only
  def otp_fresh?
    (Time.current - otp_generated_at) / 1.day < 1
  end

  def update_otp_after_pass_set
    update(one_time_password: false, encrypted_otp: '', logged_in_via: 'pass') if logged_in_via?('otp')
  end

  def update_pass_after_otp_log_in(update_params)
    return false unless logged_in_via?('otp')

    update(password: update_params[:password],
           password_confirmation: update_params[:password_confirmation]
          )
  end

  # maybe rename this method somehow
  def custom_schedule(schedule)
    schedules << schedule.create_custom
    save
  end
end
