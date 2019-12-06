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

  def full_name
    first_name + ' ' + last_name
  end

  # it's needed to escape devise's extreme depending on emails
  def email_changed?
    false
  end

  # maybe rename this method somehow
  def custom_schedule(schedule)
    schedules << schedule.create_custom
    save
  end
end
