# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :redirect_if_otp
end
