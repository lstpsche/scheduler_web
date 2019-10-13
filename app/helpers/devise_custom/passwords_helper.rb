# frozen_string_literal: true

module DeviseCustom
  module PasswordsHelper
    def generate_password
      @password = SecureRandom.hex(4)
    end

    def hash_auth_token(username)
      Digest::SHA256.hexdigest(username + ENV['REQUEST_SALT'])
    end

    def http_validity_token
      request.env['HTTP_VALIDITY_TOKEN']
    end

    def send_one_time_password
      text = I18n.t('telegram_bot.one_time_password', password: @password)
      BotActionsService.new(user).send_message(text)
    end

    def set_one_time_password
      user.encrypted_otp = hash_password(@password, user.username)
      user.otp_generated_at = Time.current
      user.one_time_password = true
    end

    def validity_token_match?
      return false unless http_validity_token.present?

      http_validity_token == hash_auth_token(user.username)
    end
  end
end
